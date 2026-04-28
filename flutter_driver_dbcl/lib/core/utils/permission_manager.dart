import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static Future<bool> requestMonitoringPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.sensors,
      Permission.locationWhenInUse,
    ].request();

    return statuses.values.every((status) => status.isGranted);
  }

  static Future<bool> requestLocationForTrip() async {
    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  static Future<bool> checkOverlay() async {
    return await Permission.systemAlertWindow.isGranted;
  }
}
