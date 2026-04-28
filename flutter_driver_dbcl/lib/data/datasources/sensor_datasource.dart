import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import '../../core/constants/scoring_rules.dart';

class SensorDataSource {
  StreamSubscription<UserAccelerometerEvent>? _subscription;
  final Function(double gForce) onHardBrakeDetected;

  SensorDataSource({required this.onHardBrakeDetected});

  void start() {
    _subscription = userAccelerometerEventStream().listen((UserAccelerometerEvent event) {
      // Calculate G-force: sqrt(x^2 + y^2 + z^2)
      final double gForce = (event.x.abs() + event.y.abs() + event.z.abs()) / 9.81;

      if (gForce >= ScoringRules.hardBrakeGForce) {
        onHardBrakeDetected(gForce);
      }
    });
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }
}
