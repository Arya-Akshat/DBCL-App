// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driver_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DriverState {
  String get driverId => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  double get currentEar => throw _privateConstructorUsedError;
  bool get isDrowsy => throw _privateConstructorUsedError;
  bool get isDistracted => throw _privateConstructorUsedError;
  bool get isMonitoring => throw _privateConstructorUsedError;
  bool get faceVisible => throw _privateConstructorUsedError;
  bool get isEmulator => throw _privateConstructorUsedError;
  @JsonKey(includeFromJson: false, includeToJson: false)
  CameraController? get controller => throw _privateConstructorUsedError;
  String get alertMessage => throw _privateConstructorUsedError;
  Map<String, dynamic>? get sessionSummary =>
      throw _privateConstructorUsedError;
  List<DrivingEvent> get liveEvents => throw _privateConstructorUsedError;

  /// Create a copy of DriverState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DriverStateCopyWith<DriverState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DriverStateCopyWith<$Res> {
  factory $DriverStateCopyWith(
    DriverState value,
    $Res Function(DriverState) then,
  ) = _$DriverStateCopyWithImpl<$Res, DriverState>;
  @useResult
  $Res call({
    String driverId,
    int score,
    double currentEar,
    bool isDrowsy,
    bool isDistracted,
    bool isMonitoring,
    bool faceVisible,
    bool isEmulator,
    @JsonKey(includeFromJson: false, includeToJson: false)
    CameraController? controller,
    String alertMessage,
    Map<String, dynamic>? sessionSummary,
    List<DrivingEvent> liveEvents,
  });
}

/// @nodoc
class _$DriverStateCopyWithImpl<$Res, $Val extends DriverState>
    implements $DriverStateCopyWith<$Res> {
  _$DriverStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DriverState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? driverId = null,
    Object? score = null,
    Object? currentEar = null,
    Object? isDrowsy = null,
    Object? isDistracted = null,
    Object? isMonitoring = null,
    Object? faceVisible = null,
    Object? isEmulator = null,
    Object? controller = freezed,
    Object? alertMessage = null,
    Object? sessionSummary = freezed,
    Object? liveEvents = null,
  }) {
    return _then(
      _value.copyWith(
            driverId: null == driverId
                ? _value.driverId
                : driverId // ignore: cast_nullable_to_non_nullable
                      as String,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as int,
            currentEar: null == currentEar
                ? _value.currentEar
                : currentEar // ignore: cast_nullable_to_non_nullable
                      as double,
            isDrowsy: null == isDrowsy
                ? _value.isDrowsy
                : isDrowsy // ignore: cast_nullable_to_non_nullable
                      as bool,
            isDistracted: null == isDistracted
                ? _value.isDistracted
                : isDistracted // ignore: cast_nullable_to_non_nullable
                      as bool,
            isMonitoring: null == isMonitoring
                ? _value.isMonitoring
                : isMonitoring // ignore: cast_nullable_to_non_nullable
                      as bool,
            faceVisible: null == faceVisible
                ? _value.faceVisible
                : faceVisible // ignore: cast_nullable_to_non_nullable
                      as bool,
            isEmulator: null == isEmulator
                ? _value.isEmulator
                : isEmulator // ignore: cast_nullable_to_non_nullable
                      as bool,
            controller: freezed == controller
                ? _value.controller
                : controller // ignore: cast_nullable_to_non_nullable
                      as CameraController?,
            alertMessage: null == alertMessage
                ? _value.alertMessage
                : alertMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            sessionSummary: freezed == sessionSummary
                ? _value.sessionSummary
                : sessionSummary // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            liveEvents: null == liveEvents
                ? _value.liveEvents
                : liveEvents // ignore: cast_nullable_to_non_nullable
                      as List<DrivingEvent>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DriverStateImplCopyWith<$Res>
    implements $DriverStateCopyWith<$Res> {
  factory _$$DriverStateImplCopyWith(
    _$DriverStateImpl value,
    $Res Function(_$DriverStateImpl) then,
  ) = __$$DriverStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String driverId,
    int score,
    double currentEar,
    bool isDrowsy,
    bool isDistracted,
    bool isMonitoring,
    bool faceVisible,
    bool isEmulator,
    @JsonKey(includeFromJson: false, includeToJson: false)
    CameraController? controller,
    String alertMessage,
    Map<String, dynamic>? sessionSummary,
    List<DrivingEvent> liveEvents,
  });
}

/// @nodoc
class __$$DriverStateImplCopyWithImpl<$Res>
    extends _$DriverStateCopyWithImpl<$Res, _$DriverStateImpl>
    implements _$$DriverStateImplCopyWith<$Res> {
  __$$DriverStateImplCopyWithImpl(
    _$DriverStateImpl _value,
    $Res Function(_$DriverStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DriverState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? driverId = null,
    Object? score = null,
    Object? currentEar = null,
    Object? isDrowsy = null,
    Object? isDistracted = null,
    Object? isMonitoring = null,
    Object? faceVisible = null,
    Object? isEmulator = null,
    Object? controller = freezed,
    Object? alertMessage = null,
    Object? sessionSummary = freezed,
    Object? liveEvents = null,
  }) {
    return _then(
      _$DriverStateImpl(
        driverId: null == driverId
            ? _value.driverId
            : driverId // ignore: cast_nullable_to_non_nullable
                  as String,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as int,
        currentEar: null == currentEar
            ? _value.currentEar
            : currentEar // ignore: cast_nullable_to_non_nullable
                  as double,
        isDrowsy: null == isDrowsy
            ? _value.isDrowsy
            : isDrowsy // ignore: cast_nullable_to_non_nullable
                  as bool,
        isDistracted: null == isDistracted
            ? _value.isDistracted
            : isDistracted // ignore: cast_nullable_to_non_nullable
                  as bool,
        isMonitoring: null == isMonitoring
            ? _value.isMonitoring
            : isMonitoring // ignore: cast_nullable_to_non_nullable
                  as bool,
        faceVisible: null == faceVisible
            ? _value.faceVisible
            : faceVisible // ignore: cast_nullable_to_non_nullable
                  as bool,
        isEmulator: null == isEmulator
            ? _value.isEmulator
            : isEmulator // ignore: cast_nullable_to_non_nullable
                  as bool,
        controller: freezed == controller
            ? _value.controller
            : controller // ignore: cast_nullable_to_non_nullable
                  as CameraController?,
        alertMessage: null == alertMessage
            ? _value.alertMessage
            : alertMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        sessionSummary: freezed == sessionSummary
            ? _value._sessionSummary
            : sessionSummary // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        liveEvents: null == liveEvents
            ? _value._liveEvents
            : liveEvents // ignore: cast_nullable_to_non_nullable
                  as List<DrivingEvent>,
      ),
    );
  }
}

/// @nodoc

class _$DriverStateImpl implements _DriverState {
  const _$DriverStateImpl({
    this.driverId = '',
    this.score = 1000,
    this.currentEar = 1.0,
    this.isDrowsy = false,
    this.isDistracted = false,
    this.isMonitoring = false,
    this.faceVisible = false,
    this.isEmulator = false,
    @JsonKey(includeFromJson: false, includeToJson: false)
    this.controller = null,
    this.alertMessage = '',
    final Map<String, dynamic>? sessionSummary,
    final List<DrivingEvent> liveEvents = const [],
  }) : _sessionSummary = sessionSummary,
       _liveEvents = liveEvents;

  @override
  @JsonKey()
  final String driverId;
  @override
  @JsonKey()
  final int score;
  @override
  @JsonKey()
  final double currentEar;
  @override
  @JsonKey()
  final bool isDrowsy;
  @override
  @JsonKey()
  final bool isDistracted;
  @override
  @JsonKey()
  final bool isMonitoring;
  @override
  @JsonKey()
  final bool faceVisible;
  @override
  @JsonKey()
  final bool isEmulator;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final CameraController? controller;
  @override
  @JsonKey()
  final String alertMessage;
  final Map<String, dynamic>? _sessionSummary;
  @override
  Map<String, dynamic>? get sessionSummary {
    final value = _sessionSummary;
    if (value == null) return null;
    if (_sessionSummary is EqualUnmodifiableMapView) return _sessionSummary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<DrivingEvent> _liveEvents;
  @override
  @JsonKey()
  List<DrivingEvent> get liveEvents {
    if (_liveEvents is EqualUnmodifiableListView) return _liveEvents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_liveEvents);
  }

  @override
  String toString() {
    return 'DriverState(driverId: $driverId, score: $score, currentEar: $currentEar, isDrowsy: $isDrowsy, isDistracted: $isDistracted, isMonitoring: $isMonitoring, faceVisible: $faceVisible, isEmulator: $isEmulator, controller: $controller, alertMessage: $alertMessage, sessionSummary: $sessionSummary, liveEvents: $liveEvents)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DriverStateImpl &&
            (identical(other.driverId, driverId) ||
                other.driverId == driverId) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.currentEar, currentEar) ||
                other.currentEar == currentEar) &&
            (identical(other.isDrowsy, isDrowsy) ||
                other.isDrowsy == isDrowsy) &&
            (identical(other.isDistracted, isDistracted) ||
                other.isDistracted == isDistracted) &&
            (identical(other.isMonitoring, isMonitoring) ||
                other.isMonitoring == isMonitoring) &&
            (identical(other.faceVisible, faceVisible) ||
                other.faceVisible == faceVisible) &&
            (identical(other.isEmulator, isEmulator) ||
                other.isEmulator == isEmulator) &&
            (identical(other.controller, controller) ||
                other.controller == controller) &&
            (identical(other.alertMessage, alertMessage) ||
                other.alertMessage == alertMessage) &&
            const DeepCollectionEquality().equals(
              other._sessionSummary,
              _sessionSummary,
            ) &&
            const DeepCollectionEquality().equals(
              other._liveEvents,
              _liveEvents,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    driverId,
    score,
    currentEar,
    isDrowsy,
    isDistracted,
    isMonitoring,
    faceVisible,
    isEmulator,
    controller,
    alertMessage,
    const DeepCollectionEquality().hash(_sessionSummary),
    const DeepCollectionEquality().hash(_liveEvents),
  );

  /// Create a copy of DriverState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DriverStateImplCopyWith<_$DriverStateImpl> get copyWith =>
      __$$DriverStateImplCopyWithImpl<_$DriverStateImpl>(this, _$identity);
}

abstract class _DriverState implements DriverState {
  const factory _DriverState({
    final String driverId,
    final int score,
    final double currentEar,
    final bool isDrowsy,
    final bool isDistracted,
    final bool isMonitoring,
    final bool faceVisible,
    final bool isEmulator,
    @JsonKey(includeFromJson: false, includeToJson: false)
    final CameraController? controller,
    final String alertMessage,
    final Map<String, dynamic>? sessionSummary,
    final List<DrivingEvent> liveEvents,
  }) = _$DriverStateImpl;

  @override
  String get driverId;
  @override
  int get score;
  @override
  double get currentEar;
  @override
  bool get isDrowsy;
  @override
  bool get isDistracted;
  @override
  bool get isMonitoring;
  @override
  bool get faceVisible;
  @override
  bool get isEmulator;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  CameraController? get controller;
  @override
  String get alertMessage;
  @override
  Map<String, dynamic>? get sessionSummary;
  @override
  List<DrivingEvent> get liveEvents;

  /// Create a copy of DriverState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DriverStateImplCopyWith<_$DriverStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
