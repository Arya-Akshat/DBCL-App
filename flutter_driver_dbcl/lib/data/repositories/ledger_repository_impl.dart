import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/driving_event.dart';
import '../../domain/repositories/ledger_repository.dart';
import '../datasources/local_database.dart' as db;
import '../../core/constants/scoring_rules.dart';

class LedgerRepositoryImpl implements ILedgerRepository {
  final db.AppDatabase database;
  final _uuid = const Uuid();

  LedgerRepositoryImpl(this.database);

  @override
  Future<void> applyScoreDelta(String driverId, int delta, DrivingEvent event) async {
    return database.transaction(() async {
      final currentScore = await getScore(driverId);
      final newScore = (currentScore + delta).clamp(
        ScoringRules.minScore,
        ScoringRules.maxScore,
      );

      // Update Ledger
      await database.into(database.creditLedger).insertOnConflictUpdate(
            db.CreditLedgerCompanion(
              driverId: Value(driverId),
              currentScore: Value(newScore),
              lastUpdated: Value(DateTime.now()),
            ),
          );

      // Log Event
      await database.into(database.drivingEvents).insert(
            db.DrivingEventsCompanion.insert(
              id: _uuid.v4(),
              driverId: driverId,
              timestamp: DateTime.now(),
              eventType: event.when(
                hardBrakeDetected: (gForce) => 'HARD_BRAKE',
                fatigueDetected: (ear, durationMs) => 'FATIGUE',
                drowsyDetected: (ear, durationMs) => 'DROWSY',
                faceVerificationFailed: (similarity) => 'FACE_FAIL',
                alcoholDetected: (confidence) => 'ALCOHOL',
                distractionDetected: (durationMs) => 'DISTRACTION',
                recoveryBonus: (reason, points) => 'RECOVERY_$reason',
              ),
              scoreDelta: delta,
              scoreBefore: currentScore,
              scoreAfter: newScore,
              metadata: '{}', // Placeholder
            ),
          );
    });
  }

  @override
  Future<int> getScore(String driverId) async {
    final entry = await (database.select(database.creditLedger)..where((t) => t.driverId.equals(driverId))).getSingleOrNull();
    return entry?.currentScore ?? ScoringRules.initialScore;
  }

  @override
  Future<void> initLedger(String driverId) async {
    await database.into(database.creditLedger).insertOnConflictUpdate(
          db.CreditLedgerCompanion(
            driverId: Value(driverId),
            currentScore: const Value(ScoringRules.initialScore),
            lastUpdated: Value(DateTime.now()),
          ),
        );
  }

  @override
  Stream<int> observeScore(String driverId) {
    try {
      return (database.select(database.creditLedger)..where((t) => t.driverId.equals(driverId)))
          .watchSingle()
          .map((row) => row.currentScore);
    } catch (e) {
      return Stream.value(ScoringRules.initialScore);
    }
  }

  @override
  Future<List<DrivingEvent>> getEvents(String driverId) async {
    final rows = await (database.select(database.drivingEvents)
          ..where((t) => t.driverId.equals(driverId))
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)]))
        .get();
    
    // Convert DB rows back to Domain entities
    return rows.map((row) {
      switch (row.eventType) {
        case 'FATIGUE': return DrivingEvent.fatigueDetected(ear: 0.15, durationMs: 2000);
        case 'DROWSY': return DrivingEvent.drowsyDetected(ear: 0.20, durationMs: 1500);
        case 'ALCOHOL': return DrivingEvent.alcoholDetected(confidence: 0.95);
        default: return DrivingEvent.hardBrakeDetected(gForce: 1.5);
      }
    }).toList();
  }

  @override
  Future<List<dynamic>> getTrips(String driverId) async {
    return await (database.select(database.trips)
          ..where((t) => t.driverId.equals(driverId))
          ..orderBy([(t) => OrderingTerm.desc(t.startTime)]))
        .get();
  }
}
