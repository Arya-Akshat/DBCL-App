import 'dart:async';
import '../domain/entities/driving_event.dart';

class ApiService {
  static Future<List<DrivingEvent>> fetchEvents() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return [
        DrivingEvent.fatigueDetected(ear: 0.12, durationMs: 2500),
        DrivingEvent.hardBrakeDetected(gForce: 1.8),
        DrivingEvent.distractionDetected(durationMs: 3000),
      ];
    } catch (e) {
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> fetchTrips() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return [
        {
          'id': 'trip_1',
          'startTime': DateTime.now().subtract(const Duration(hours: 2)),
          'score': 950,
          'duration': '1h 20m',
          'events': 2,
          'bonus': 15,
        },
        {
          'id': 'trip_2',
          'startTime': DateTime.now().subtract(const Duration(days: 1)),
          'score': 880,
          'duration': '45m',
          'events': 5,
          'bonus': 5,
        },
      ];
    } catch (e) {
      return [];
    }
  }
}
