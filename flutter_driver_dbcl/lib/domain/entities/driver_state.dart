import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'driving_event.dart';

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
    @Default(null) @JsonKey(includeFromJson: false, includeToJson: false) CameraController? controller,
    @Default('') String alertMessage,
    Map<String, dynamic>? sessionSummary,
    @Default([]) List<DrivingEvent> liveEvents,
  }) = _DriverState;
}
