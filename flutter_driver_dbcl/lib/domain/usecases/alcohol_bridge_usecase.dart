import '../../core/constants/scoring_rules.dart';
import '../repositories/ledger_repository.dart';
import '../entities/driving_event.dart';

class AlcoholBridgeUseCase {
  final ILedgerRepository ledgerRepo;

  AlcoholBridgeUseCase(this.ledgerRepo);

  Future<void> onAlcoholDetected(String driverId, double confidence) async {
    await ledgerRepo.applyScoreDelta(
      driverId,
      ScoringRules.alcoholPenalty,
      DrivingEvent.alcoholDetected(confidence: confidence),
    );
  }
}
