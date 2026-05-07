import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AiVisionResult {
  final double ear;
  final bool handNearEar;
  final bool faceVisible;
  final List<double>? embedding;

  AiVisionResult({
    required this.ear,
    required this.handNearEar,
    required this.faceVisible,
    this.embedding,
  });

  factory AiVisionResult.fromMap(Map<dynamic, dynamic> map) {
    return AiVisionResult(
      ear: (map['ear'] as num).toDouble(),
      handNearEar: map['handNearEar'] as bool,
      faceVisible: map['faceVisible'] as bool,
      embedding: (map['embedding'] as List?)?.cast<double>(),
    );
  }
}

class AiVisionDataSource {
  static const _channel = MethodChannel('com.kislay.driver_dbcl/ai');
  int _frameCount = 0;

  Future<AiVisionResult> processFrame({
    required Uint8List y,
    required Uint8List u,
    required Uint8List v,
    required int width,
    required int height,
    required int rotation,
    bool detectFace = false,
  }) async {
    try {
      final result = await _channel.invokeMethod('processFrame', {
        'y': y,
        'u': u,
        'v': v,
        'width': width,
        'height': height,
        'rotation': rotation,
        'detectFace': detectFace,
      });
      final parsed = AiVisionResult.fromMap(result as Map);
      
      // Log every 10th frame to avoid spam but keep visibility
      _frameCount++;
      if (_frameCount % 10 == 0) {
        debugPrint('[AI] Frame #$_frameCount: ear=${parsed.ear.toStringAsFixed(3)}, '
            'face=${parsed.faceVisible}, hand=${parsed.handNearEar}');
      }
      
      return parsed;
    } catch (e) {
      debugPrint('[AI] ERROR processing frame: $e');
      return AiVisionResult(ear: 1.0, handNearEar: false, faceVisible: false);
    }
  }
}
