import '../../core/constants/scoring_rules.dart';
import '../repositories/ledger_repository.dart';
import '../entities/driving_event.dart';

class DetectFatigueUseCase {
  final ILedgerRepository ledgerRepo;

  DetectFatigueUseCase(this.ledgerRepo);

  int? _eyeClosedStart;
  int _lastFatigueTime = 0;
  int _lastDrowsyTime = 0;
  bool _fatigueFired = false;
  bool _drowsyFired = false;

  Future<void> onFrame(String driverId, double ear) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final eyesClosed = ear < ScoringRules.earThreshold;

    if (eyesClosed) {
      _eyeClosedStart ??= now;
      final closedMs = now - _eyeClosedStart!;

      // Tier 1: Fatigue warning (1.5s)
      if (closedMs >= ScoringRules.fatigueTimeMs &&
          !_fatigueFired &&
          now - _lastFatigueTime >= ScoringRules.fatigueCooldownMs) {
        _fatigueFired = true;
        _lastFatigueTime = now;
        await ledgerRepo.applyScoreDelta(
          driverId,
          ScoringRules.fatiguePenalty,
          DrivingEvent.fatigueDetected(ear: ear, durationMs: closedMs),
        );
      }

      // Tier 2: Drowsy alert (3.0s)
      if (closedMs >= ScoringRules.drowsyTimeMs &&
          !_drowsyFired &&
          now - _lastDrowsyTime >= ScoringRules.drowsyCooldownMs) {
        _drowsyFired = true;
        _lastDrowsyTime = now;
        await ledgerRepo.applyScoreDelta(
          driverId,
          ScoringRules.drowsyPenalty,
          DrivingEvent.drowsyDetected(ear: ear, durationMs: closedMs),
        );
      }
    } else {
      _eyeClosedStart = null;
      _fatigueFired = false;
      _drowsyFired = false;
    }
  }
}
