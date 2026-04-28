import 'package:freezed_annotation/freezed_annotation.dart';

part 'driver_state.freezed.dart';

@freezed
class DriverState with _$DriverState {
  const factory DriverState({
    @Default('') String driverId,
    @Default(1000) int score,
    @Default(1.0) double currentEar,
    @Default(false) bool isDrowsy,
    @Default(false) bool isDistracted,
    @Default(false) bool isMonitoring,
    @Default(false) bool faceVisible,
    @Default(false) bool isEmulator,
    @Default('') String alertMessage,
  }) = _DriverState;
}
