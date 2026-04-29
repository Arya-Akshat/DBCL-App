import 'dart:async';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img_lib;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/utils/permission_manager.dart';
import '../../domain/entities/driver_state.dart';
import '../../domain/entities/driving_event.dart';
import '../../providers/app_providers.dart';
import '../providers/repository_provider.dart';
import '../providers/usecase_provider.dart';
import '../../services/camera_service.dart';

part 'monitoring_provider.g.dart';

@Riverpod(keepAlive: true)
class MonitoringNotifier extends _$MonitoringNotifier {
  bool _hasCamera = true;
  bool _isProcessing = false;
  int _eventCount = 0;
  DateTime _lastFrameTime = DateTime.now();
  DateTime _sessionStartTime = DateTime.now();
  bool _isUploadingFrame = false;

  @override
  DriverState build() {
    _checkMonitoringAvailability();
    final driverId = ref.watch(appControllerProvider).valueOrNull?.currentUser?.userId ?? '';

    final repo = ref.watch(ledgerRepositoryProvider);
    if (driverId.isNotEmpty) {
      unawaited(repo.initLedger(driverId));
      try {
        repo.observeScore(driverId).listen((score) {
          state = state.copyWith(score: score);
        }, onError: (e) {
          debugPrint("Score Observation Error: $e");
        });
      } catch (e) {
        debugPrint("Failed to start score observation: $e");
      }
    }

    return DriverState(driverId: driverId);
  }

  Future<void> _checkMonitoringAvailability() async {
    final isEmulator = await CameraService.isEmulator();
    _hasCamera = await CameraService.isCameraAvailable();
    if (isEmulator || !_hasCamera) {
      state = state.copyWith(
        isEmulator: isEmulator,
        alertMessage: "No camera found in emulator. Use real device.",
      );
      return;
    }
    state = state.copyWith(isEmulator: false, alertMessage: "");
  }

  Future<void> startMonitoring() async {
    if (state.isMonitoring) return;
    if (state.isEmulator || !_hasCamera) {
      state = state.copyWith(alertMessage: "No camera found in emulator. Use real device.");
      return;
    }

    // Only Camera is strictly required for the visual monitoring feed
    final cameraStatus = await Permission.camera.request();
    
    // Request others but don't block
    unawaited(Permission.locationWhenInUse.request());
    
    debugPrint("DEBUG: Camera permission status: $cameraStatus");
    
    if (!cameraStatus.isGranted) {
      state = state.copyWith(alertMessage: "Camera permission is required to start monitoring.");
      return;
    }

    try {
      final cameras = await availableCameras();
      debugPrint("[MONITOR] Available cameras: ${cameras.length}");
      if (cameras.isEmpty) {
        state = state.copyWith(alertMessage: "No Camera Detected");
        return;
      }

      final frontCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );
      debugPrint("[MONITOR] Selected camera: ${frontCamera.name}");

      final controller = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      debugPrint("[MONITOR] Initializing controller...");
      await controller.initialize();
      debugPrint("[MONITOR] Controller initialized.");
      
      state = state.copyWith(
        isMonitoring: true, 
        alertMessage: "Your camera is turned on",
        controller: controller,
        sessionSummary: null,
        liveEvents: [],
      );
      
      _eventCount = 0;
      _sessionStartTime = DateTime.now();

      // Start Trip on Backend
      try {
        debugPrint("[MONITOR] Starting backend trip...");
        await ref.read(dbclApiServiceProvider).startTrip(
          token: state.driverId,
          startTime: DateTime.now().toIso8601String(),
        );
      } catch (e) {
        debugPrint("[MONITOR] Backend trip failed: $e");
      }

      debugPrint("[MONITOR] Starting image stream...");
      await controller.startImageStream((CameraImage image) {
        _processCameraImage(image);
      });
      debugPrint("[MONITOR] Image stream started.");

    } catch (e) {
      debugPrint("[MONITOR] FATAL ERROR: $e");
      state = state.copyWith(alertMessage: "Camera Init Failed: $e");
    }
  }

  Future<void> stopMonitoring() async {
    try {
      await state.controller?.dispose();
      
      // End Trip on Backend
      if (state.isMonitoring) {
        final duration = DateTime.now().difference(_sessionStartTime).inSeconds;
        final summary = {
          'duration': duration,
          'events': _eventCount,
          'score': state.score,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        };

        try {
          // Notify Dashboard of stop
          ref.read(dbclApiServiceProvider).uploadVideoMetadata(
            userId: state.driverId,
            metadata: {'timestamp': 0, 'ear': 0.0, 'hand_on_wheel': false},
          );

          await ref.read(dbclApiServiceProvider).endTrip(
            token: state.driverId,
            endTime: DateTime.now().toIso8601String(),
            score: state.score,
            eventsCount: _eventCount,
          );
        } catch (e) {
          debugPrint("Failed to end trip on backend: $e");
        }

        state = state.copyWith(
          isMonitoring: false,
          faceVisible: false,
          controller: null,
          sessionSummary: summary,
          alertMessage: "",
        );
      }
    } catch (e) {
      debugPrint("Error stopping camera: $e");
    }
  }

  Future<void> _processCameraImage(CameraImage image) async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      final aiDataSource = ref.read(aiVisionDataSourceProvider);
      final fatigueUseCase = ref.read(detectFatigueUseCaseProvider);
      final driverId = state.driverId;

      if (driverId.isEmpty) return;

      final result = await aiDataSource.processFrame(
        y: image.planes[0].bytes,
        u: image.planes[1].bytes,
        v: image.planes[2].bytes,
        width: image.width,
        height: image.height,
        rotation: 90, // Assuming portrait for now
      );

      final now = DateTime.now();
      
      // Drowsiness Detection
      if (result.ear < 0.2 && !state.isDrowsy) {
        final event = DrivingEvent.drowsyDetected(
          ear: result.ear,
          durationMs: 1000,
        );
        
        state = state.copyWith(
          isDrowsy: true,
          currentEar: result.ear,
          faceVisible: result.faceVisible,
          liveEvents: [event, ...state.liveEvents],
        );
        
        unawaited(ref.read(ledgerRepositoryProvider).applyScoreDelta(driverId, -50, event));
        unawaited(ref.read(dbclApiServiceProvider).logEvent(
          userId: driverId,
          event: {'event_type': 'drowsiness', 'timestamp': now.millisecondsSinceEpoch},
        ));
        
        _eventCount++;
      } else if (result.ear >= 0.2 && state.isDrowsy) {
        state = state.copyWith(isDrowsy: false, currentEar: result.ear, faceVisible: result.faceVisible);
      } else {
        state = state.copyWith(currentEar: result.ear, faceVisible: result.faceVisible);
      }

      // Distraction Detection
      if (result.handNearEar && !state.isDistracted) {
        final event = DrivingEvent.distractionDetected(
          durationMs: 1000,
        );
        
        state = state.copyWith(
          isDistracted: true,
          liveEvents: [event, ...state.liveEvents],
        );
        
        unawaited(ref.read(ledgerRepositoryProvider).applyScoreDelta(driverId, -20, event));
        unawaited(ref.read(dbclApiServiceProvider).logEvent(
          userId: driverId,
          event: {'event_type': 'distraction', 'timestamp': now.millisecondsSinceEpoch},
        ));
        
        _eventCount++;
      }
 else if (!result.handNearEar && state.isDistracted) {
        state = state.copyWith(isDistracted: false);
      }

      await fatigueUseCase.onFrame(driverId, result.ear);

      // Live Feed Upload for Dashboard (FIXED 1FPS)
      if (!_isUploadingFrame && now.difference(_lastFrameTime).inMilliseconds >= 1000) {
        _lastFrameTime = now;
        _isUploadingFrame = true;
        _uploadFrame(image, driverId, result).then((_) => _isUploadingFrame = false);
      }
      
    } catch (e) {
      debugPrint("AI Processing Error: $e");
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _uploadFrame(CameraImage image, String userId, dynamic result) async {
    final controller = state.controller;
    if (controller == null || !controller.value.isInitialized) {
      debugPrint('[UPLOAD] Camera not ready, skipping frame');
      return;
    }

    try {
      final img = _convertYUV420ToImage(image);
      // Option A: 270 degree rotation + flip for front-facing portrait camera
      final rotated = img_lib.copyRotate(img, angle: 270);
      final flipped = img_lib.flipHorizontal(rotated);
      final jpeg = img_lib.encodeJpg(flipped, quality: 30);
      
      final uploadUrl = "${ref.read(dbclApiServiceProvider).baseUrl}/video_feed/$userId";
      debugPrint('[UPLOAD] Posting frame to: $uploadUrl, size: ${jpeg.length} bytes');
      
      // Upload metadata first
      await ref.read(dbclApiServiceProvider).uploadVideoMetadata(
        userId: userId,
        metadata: {
          'ear': result.ear,
          'hand_near_ear': result.handNearEar,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );

      await ref.read(dbclApiServiceProvider).uploadVideoFrame(
        userId: userId,
        imageBytes: jpeg,
      );
    } catch (e) {
      debugPrint('[UPLOAD] FATAL ERROR in _uploadFrame: $e');
    }
  }

  img_lib.Image _convertYUV420ToImage(CameraImage image) {
    final int width = image.width;
    final int height = image.height;
    var img = img_lib.Image(width: width, height: height);

    final yPlane = image.planes[0].bytes;
    final uPlane = image.planes[1].bytes;
    final vPlane = image.planes[2].bytes;

    final int yRowStride = image.planes[0].bytesPerRow;
    final int uvRowStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel!;

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int uvIndex = (y >> 1) * uvRowStride + (x >> 1) * uvPixelStride;
        final int yIndex = y * yRowStride + x;

        final int yp = yPlane[yIndex];
        final int up = uPlane[uvIndex];
        final int vp = vPlane[uvIndex];

        int r = (yp + vPlane[uvIndex] * 1436 / 1024 - 179).round();
        int g = (yp - uPlane[uvIndex] * 46549 / 131072 + 44 - vPlane[uvIndex] * 93604 / 131072 + 91).round();
        int b = (yp + uPlane[uvIndex] * 1814 / 1024 - 227).round();

        r = r.clamp(0, 255);
        g = g.clamp(0, 255);
        b = b.clamp(0, 255);

        img.setPixelRgb(x, y, r, g, b);
      }
    }
    return img;
  }
}
