import 'package:camera/camera.dart';
import 'package:device_info_plus/device_info_plus.dart';

class CameraService {
  static Future<bool> isCameraAvailable() async {
    try {
      final cameras = await availableCameras();
      return cameras.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> isEmulator() async {
    try {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      return !androidInfo.isPhysicalDevice;
    } catch (_) {
      try {
        final deviceInfo = DeviceInfoPlugin();
        final iosInfo = await deviceInfo.iosInfo;
        return !iosInfo.isPhysicalDevice;
      } catch (_) {
        return false;
      }
    }
  }
}
