import '../entities/driving_event.dart';

abstract class ILedgerRepository {
  Future<int> getScore(String driverId);
  Stream<int> observeScore(String driverId);
  Future<void> initLedger(String driverId);
  Future<void> applyScoreDelta(String driverId, int delta, DrivingEvent event);
  Future<List<DrivingEvent>> getEvents(String driverId);
  Future<List<dynamic>> getTrips(String driverId);
}
