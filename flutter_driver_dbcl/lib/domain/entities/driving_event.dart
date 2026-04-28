import 'package:freezed_annotation/freezed_annotation.dart';

part 'driving_event.freezed.dart';

@freezed
class DrivingEvent with _$DrivingEvent {
  const factory DrivingEvent.hardBrakeDetected({
    required double gForce,
  }) = HardBrakeDetected;

  const factory DrivingEvent.fatigueDetected({
    required double ear,
    required int durationMs,
  }) = FatigueDetected;

  const factory DrivingEvent.drowsyDetected({
    required double ear,
    required int durationMs,
  }) = DrowsyDetected;

  const factory DrivingEvent.faceVerificationFailed({
    @Default(0.0) double similarity,
  }) = FaceVerificationFailed;

  const factory DrivingEvent.alcoholDetected({
    @Default(1.0) double confidence,
  }) = AlcoholDetected;

  const factory DrivingEvent.distractionDetected({
    required int durationMs,
  }) = DistractionDetected;

  const factory DrivingEvent.recoveryBonus({
    required String reason,
    required int points,
  }) = RecoveryBonus;
}
