import 'dart:async';
import 'dart:ui';
import 'package:flutter_background_service/flutter_background_service.dart';

@pragma('vm:entry-point')
class BackgroundServiceManager {
  static Future<void> initialize() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: false,
        isForegroundMode: true,
        notificationChannelId: 'dbcl_monitoring',
        initialNotificationTitle: 'DBCL Monitoring',
        initialNotificationContent: 'System is active',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: false,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
    );
  }

  @pragma('vm:entry-point')
  static Future<bool> onIosBackground(ServiceInstance service) async {
    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    DartPluginRegistrant.ensureInitialized();

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    // --- Monitoring Loop ---
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          // Here we would trigger the camera processing if we can access it from background
          // Note: Camera access in background on Android requires a Foreground Service
          // and specific permissions.
          service.setForegroundNotificationInfo(
            title: "DBCL Active",
            content: "Monitoring driver attentiveness...",
          );
        }
      }

      // Send data back to UI
      service.invoke('update', {
        "current_score": 1000, // Replace with real score from DB
      });
    });
  }
}
