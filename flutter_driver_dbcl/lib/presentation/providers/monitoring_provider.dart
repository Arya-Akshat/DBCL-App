import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/utils/permission_manager.dart';
import '../../domain/entities/driver_state.dart';
import '../../providers/app_providers.dart';
import '../providers/repository_provider.dart';
import '../../services/camera_service.dart';

part 'monitoring_provider.g.dart';

@riverpod
class MonitoringNotifier extends _$MonitoringNotifier {
  CameraController? _cameraController;
  bool _hasCamera = true;

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

    final permissionsGranted = await PermissionManager.requestMonitoringPermissions();
    if (!permissionsGranted) {
      state = state.copyWith(alertMessage: "Camera, location, and sensors are required to start monitoring.");
      return;
    }

    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        state = state.copyWith(alertMessage: "No Camera Detected");
        return;
      }

      // Priority: Front Camera -> First available camera
      final frontCamera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      await _cameraController!.initialize();
      
      state = state.copyWith(isMonitoring: true, alertMessage: "");

      // DISABLE AI PIPELINE (TEMPORARY) to prevent hangs
      /*
      _cameraController!.startImageStream((CameraImage image) {
        _processCameraImage(image);
      });
      */

    } catch (e) {
      state = state.copyWith(alertMessage: "Camera Init Failed");
    }
  }

  Future<void> stopMonitoring() async {
    try {
      if (_cameraController != null && _cameraController!.value.isStreamingImages) {
        await _cameraController?.stopImageStream();
      }
      await _cameraController?.dispose();
    } catch (e) {
      debugPrint("Error stopping camera: $e");
    }
    _cameraController = null;
    state = state.copyWith(
      isMonitoring: false,
      faceVisible: false,
      alertMessage: state.isEmulator || !_hasCamera ? "No camera found in emulator. Use real device." : "",
    );
  }
}
