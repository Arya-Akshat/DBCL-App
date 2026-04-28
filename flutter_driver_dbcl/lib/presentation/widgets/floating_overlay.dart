import 'package:system_alert_window/system_alert_window.dart';

class FloatingOverlayManager {
  static Future<void> showOverlay(int score, {String alert = ""}) async {
    // Version 2.0.x of system_alert_window removed the header/body builder API.
    // For now, we will show a notification bubble as a fallback.
    // Full custom UI requires a separate entry point in 2.0.x.
    
    await SystemAlertWindow.showSystemWindow(
      height: 120,
      width: 180,
      notificationTitle: alert.isEmpty ? "DBCL Status: $score" : "ALERT: $alert",
      notificationBody: alert.isEmpty ? "Monitoring active" : "Drowsiness detected!",
      prefMode: SystemWindowPrefMode.OVERLAY,
    );
  }

  static Future<void> closeOverlay() async {
    await SystemAlertWindow.closeSystemWindow();
  }
}
