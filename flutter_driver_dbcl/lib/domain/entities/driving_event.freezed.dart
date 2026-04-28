// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'driving_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DrivingEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double gForce) hardBrakeDetected,
    required TResult Function(double ear, int durationMs) fatigueDetected,
    required TResult Function(double ear, int durationMs) drowsyDetected,
    required TResult Function(double similarity) faceVerificationFailed,
    required TResult Function(double confidence) alcoholDetected,
    required TResult Function(int durationMs) distractionDetected,
    required TResult Function(String reason, int points) recoveryBonus,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double gForce)? hardBrakeDetected,
    TResult? Function(double ear, int durationMs)? fatigueDetected,
    TResult? Function(double ear, int durationMs)? drowsyDetected,
    TResult? Function(double similarity)? faceVerificationFailed,
    TResult? Function(double confidence)? alcoholDetected,
    TResult? Function(int durationMs)? distractionDetected,
    TResult? Function(String reason, int points)? recoveryBonus,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double gForce)? hardBrakeDetected,
    TResult Function(double ear, int durationMs)? fatigueDetected,
    TResult Function(double ear, int durationMs)? drowsyDetected,
    TResult Function(double similarity)? faceVerificationFailed,
    TResult Function(double confidence)? alcoholDetected,
    TResult Function(int durationMs)? distractionDetected,
    TResult Function(String reason, int points)? recoveryBonus,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HardBrakeDetected value) hardBrakeDetected,
    required TResult Function(FatigueDetected value) fatigueDetected,
    required TResult Function(DrowsyDetected value) drowsyDetected,
    required TResult Function(FaceVerificationFailed value)
    faceVerificationFailed,
    required TResult Function(AlcoholDetected value) alcoholDetected,
    required TResult Function(DistractionDetected value) distractionDetected,
    required TResult Function(RecoveryBonus value) recoveryBonus,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult? Function(FatigueDetected value)? fatigueDetected,
    TResult? Function(DrowsyDetected value)? drowsyDetected,
    TResult? Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult? Function(AlcoholDetected value)? alcoholDetected,
    TResult? Function(DistractionDetected value)? distractionDetected,
    TResult? Function(RecoveryBonus value)? recoveryBonus,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult Function(FatigueDetected value)? fatigueDetected,
    TResult Function(DrowsyDetected value)? drowsyDetected,
    TResult Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult Function(AlcoholDetected value)? alcoholDetected,
    TResult Function(DistractionDetected value)? distractionDetected,
    TResult Function(RecoveryBonus value)? recoveryBonus,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrivingEventCopyWith<$Res> {
  factory $DrivingEventCopyWith(
    DrivingEvent value,
    $Res Function(DrivingEvent) then,
  ) = _$DrivingEventCopyWithImpl<$Res, DrivingEvent>;
}

/// @nodoc
class _$DrivingEventCopyWithImpl<$Res, $Val extends DrivingEvent>
    implements $DrivingEventCopyWith<$Res> {
  _$DrivingEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$HardBrakeDetectedImplCopyWith<$Res> {
  factory _$$HardBrakeDetectedImplCopyWith(
    _$HardBrakeDetectedImpl value,
    $Res Function(_$HardBrakeDetectedImpl) then,
  ) = __$$HardBrakeDetectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double gForce});
}

/// @nodoc
class __$$HardBrakeDetectedImplCopyWithImpl<$Res>
    extends _$DrivingEventCopyWithImpl<$Res, _$HardBrakeDetectedImpl>
    implements _$$HardBrakeDetectedImplCopyWith<$Res> {
  __$$HardBrakeDetectedImplCopyWithImpl(
    _$HardBrakeDetectedImpl _value,
    $Res Function(_$HardBrakeDetectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? gForce = null}) {
    return _then(
      _$HardBrakeDetectedImpl(
        gForce: null == gForce
            ? _value.gForce
            : gForce // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$HardBrakeDetectedImpl implements HardBrakeDetected {
  const _$HardBrakeDetectedImpl({required this.gForce});

  @override
  final double gForce;

  @override
  String toString() {
    return 'DrivingEvent.hardBrakeDetected(gForce: $gForce)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HardBrakeDetectedImpl &&
            (identical(other.gForce, gForce) || other.gForce == gForce));
  }

  @override
  int get hashCode => Object.hash(runtimeType, gForce);

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HardBrakeDetectedImplCopyWith<_$HardBrakeDetectedImpl> get copyWith =>
      __$$HardBrakeDetectedImplCopyWithImpl<_$HardBrakeDetectedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double gForce) hardBrakeDetected,
    required TResult Function(double ear, int durationMs) fatigueDetected,
    required TResult Function(double ear, int durationMs) drowsyDetected,
    required TResult Function(double similarity) faceVerificationFailed,
    required TResult Function(double confidence) alcoholDetected,
    required TResult Function(int durationMs) distractionDetected,
    required TResult Function(String reason, int points) recoveryBonus,
  }) {
    return hardBrakeDetected(gForce);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double gForce)? hardBrakeDetected,
    TResult? Function(double ear, int durationMs)? fatigueDetected,
    TResult? Function(double ear, int durationMs)? drowsyDetected,
    TResult? Function(double similarity)? faceVerificationFailed,
    TResult? Function(double confidence)? alcoholDetected,
    TResult? Function(int durationMs)? distractionDetected,
    TResult? Function(String reason, int points)? recoveryBonus,
  }) {
    return hardBrakeDetected?.call(gForce);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double gForce)? hardBrakeDetected,
    TResult Function(double ear, int durationMs)? fatigueDetected,
    TResult Function(double ear, int durationMs)? drowsyDetected,
    TResult Function(double similarity)? faceVerificationFailed,
    TResult Function(double confidence)? alcoholDetected,
    TResult Function(int durationMs)? distractionDetected,
    TResult Function(String reason, int points)? recoveryBonus,
    required TResult orElse(),
  }) {
    if (hardBrakeDetected != null) {
      return hardBrakeDetected(gForce);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HardBrakeDetected value) hardBrakeDetected,
    required TResult Function(FatigueDetected value) fatigueDetected,
    required TResult Function(DrowsyDetected value) drowsyDetected,
    required TResult Function(FaceVerificationFailed value)
    faceVerificationFailed,
    required TResult Function(AlcoholDetected value) alcoholDetected,
    required TResult Function(DistractionDetected value) distractionDetected,
    required TResult Function(RecoveryBonus value) recoveryBonus,
  }) {
    return hardBrakeDetected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult? Function(FatigueDetected value)? fatigueDetected,
    TResult? Function(DrowsyDetected value)? drowsyDetected,
    TResult? Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult? Function(AlcoholDetected value)? alcoholDetected,
    TResult? Function(DistractionDetected value)? distractionDetected,
    TResult? Function(RecoveryBonus value)? recoveryBonus,
  }) {
    return hardBrakeDetected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult Function(FatigueDetected value)? fatigueDetected,
    TResult Function(DrowsyDetected value)? drowsyDetected,
    TResult Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult Function(AlcoholDetected value)? alcoholDetected,
    TResult Function(DistractionDetected value)? distractionDetected,
    TResult Function(RecoveryBonus value)? recoveryBonus,
    required TResult orElse(),
  }) {
    if (hardBrakeDetected != null) {
      return hardBrakeDetected(this);
    }
    return orElse();
  }
}

abstract class HardBrakeDetected implements DrivingEvent {
  const factory HardBrakeDetected({required final double gForce}) =
      _$HardBrakeDetectedImpl;

  double get gForce;

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HardBrakeDetectedImplCopyWith<_$HardBrakeDetectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FatigueDetectedImplCopyWith<$Res> {
  factory _$$FatigueDetectedImplCopyWith(
    _$FatigueDetectedImpl value,
    $Res Function(_$FatigueDetectedImpl) then,
  ) = __$$FatigueDetectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double ear, int durationMs});
}

/// @nodoc
class __$$FatigueDetectedImplCopyWithImpl<$Res>
    extends _$DrivingEventCopyWithImpl<$Res, _$FatigueDetectedImpl>
    implements _$$FatigueDetectedImplCopyWith<$Res> {
  __$$FatigueDetectedImplCopyWithImpl(
    _$FatigueDetectedImpl _value,
    $Res Function(_$FatigueDetectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ear = null, Object? durationMs = null}) {
    return _then(
      _$FatigueDetectedImpl(
        ear: null == ear
            ? _value.ear
            : ear // ignore: cast_nullable_to_non_nullable
                  as double,
        durationMs: null == durationMs
            ? _value.durationMs
            : durationMs // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$FatigueDetectedImpl implements FatigueDetected {
  const _$FatigueDetectedImpl({required this.ear, required this.durationMs});

  @override
  final double ear;
  @override
  final int durationMs;

  @override
  String toString() {
    return 'DrivingEvent.fatigueDetected(ear: $ear, durationMs: $durationMs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FatigueDetectedImpl &&
            (identical(other.ear, ear) || other.ear == ear) &&
            (identical(other.durationMs, durationMs) ||
                other.durationMs == durationMs));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ear, durationMs);

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FatigueDetectedImplCopyWith<_$FatigueDetectedImpl> get copyWith =>
      __$$FatigueDetectedImplCopyWithImpl<_$FatigueDetectedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double gForce) hardBrakeDetected,
    required TResult Function(double ear, int durationMs) fatigueDetected,
    required TResult Function(double ear, int durationMs) drowsyDetected,
    required TResult Function(double similarity) faceVerificationFailed,
    required TResult Function(double confidence) alcoholDetected,
    required TResult Function(int durationMs) distractionDetected,
    required TResult Function(String reason, int points) recoveryBonus,
  }) {
    return fatigueDetected(ear, durationMs);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double gForce)? hardBrakeDetected,
    TResult? Function(double ear, int durationMs)? fatigueDetected,
    TResult? Function(double ear, int durationMs)? drowsyDetected,
    TResult? Function(double similarity)? faceVerificationFailed,
    TResult? Function(double confidence)? alcoholDetected,
    TResult? Function(int durationMs)? distractionDetected,
    TResult? Function(String reason, int points)? recoveryBonus,
  }) {
    return fatigueDetected?.call(ear, durationMs);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double gForce)? hardBrakeDetected,
    TResult Function(double ear, int durationMs)? fatigueDetected,
    TResult Function(double ear, int durationMs)? drowsyDetected,
    TResult Function(double similarity)? faceVerificationFailed,
    TResult Function(double confidence)? alcoholDetected,
    TResult Function(int durationMs)? distractionDetected,
    TResult Function(String reason, int points)? recoveryBonus,
    required TResult orElse(),
  }) {
    if (fatigueDetected != null) {
      return fatigueDetected(ear, durationMs);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HardBrakeDetected value) hardBrakeDetected,
    required TResult Function(FatigueDetected value) fatigueDetected,
    required TResult Function(DrowsyDetected value) drowsyDetected,
    required TResult Function(FaceVerificationFailed value)
    faceVerificationFailed,
    required TResult Function(AlcoholDetected value) alcoholDetected,
    required TResult Function(DistractionDetected value) distractionDetected,
    required TResult Function(RecoveryBonus value) recoveryBonus,
  }) {
    return fatigueDetected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult? Function(FatigueDetected value)? fatigueDetected,
    TResult? Function(DrowsyDetected value)? drowsyDetected,
    TResult? Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult? Function(AlcoholDetected value)? alcoholDetected,
    TResult? Function(DistractionDetected value)? distractionDetected,
    TResult? Function(RecoveryBonus value)? recoveryBonus,
  }) {
    return fatigueDetected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult Function(FatigueDetected value)? fatigueDetected,
    TResult Function(DrowsyDetected value)? drowsyDetected,
    TResult Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult Function(AlcoholDetected value)? alcoholDetected,
    TResult Function(DistractionDetected value)? distractionDetected,
    TResult Function(RecoveryBonus value)? recoveryBonus,
    required TResult orElse(),
  }) {
    if (fatigueDetected != null) {
      return fatigueDetected(this);
    }
    return orElse();
  }
}

abstract class FatigueDetected implements DrivingEvent {
  const factory FatigueDetected({
    required final double ear,
    required final int durationMs,
  }) = _$FatigueDetectedImpl;

  double get ear;
  int get durationMs;

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FatigueDetectedImplCopyWith<_$FatigueDetectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DrowsyDetectedImplCopyWith<$Res> {
  factory _$$DrowsyDetectedImplCopyWith(
    _$DrowsyDetectedImpl value,
    $Res Function(_$DrowsyDetectedImpl) then,
  ) = __$$DrowsyDetectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double ear, int durationMs});
}

/// @nodoc
class __$$DrowsyDetectedImplCopyWithImpl<$Res>
    extends _$DrivingEventCopyWithImpl<$Res, _$DrowsyDetectedImpl>
    implements _$$DrowsyDetectedImplCopyWith<$Res> {
  __$$DrowsyDetectedImplCopyWithImpl(
    _$DrowsyDetectedImpl _value,
    $Res Function(_$DrowsyDetectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? ear = null, Object? durationMs = null}) {
    return _then(
      _$DrowsyDetectedImpl(
        ear: null == ear
            ? _value.ear
            : ear // ignore: cast_nullable_to_non_nullable
                  as double,
        durationMs: null == durationMs
            ? _value.durationMs
            : durationMs // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$DrowsyDetectedImpl implements DrowsyDetected {
  const _$DrowsyDetectedImpl({required this.ear, required this.durationMs});

  @override
  final double ear;
  @override
  final int durationMs;

  @override
  String toString() {
    return 'DrivingEvent.drowsyDetected(ear: $ear, durationMs: $durationMs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrowsyDetectedImpl &&
            (identical(other.ear, ear) || other.ear == ear) &&
            (identical(other.durationMs, durationMs) ||
                other.durationMs == durationMs));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ear, durationMs);

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DrowsyDetectedImplCopyWith<_$DrowsyDetectedImpl> get copyWith =>
      __$$DrowsyDetectedImplCopyWithImpl<_$DrowsyDetectedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double gForce) hardBrakeDetected,
    required TResult Function(double ear, int durationMs) fatigueDetected,
    required TResult Function(double ear, int durationMs) drowsyDetected,
    required TResult Function(double similarity) faceVerificationFailed,
    required TResult Function(double confidence) alcoholDetected,
    required TResult Function(int durationMs) distractionDetected,
    required TResult Function(String reason, int points) recoveryBonus,
  }) {
    return drowsyDetected(ear, durationMs);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double gForce)? hardBrakeDetected,
    TResult? Function(double ear, int durationMs)? fatigueDetected,
    TResult? Function(double ear, int durationMs)? drowsyDetected,
    TResult? Function(double similarity)? faceVerificationFailed,
    TResult? Function(double confidence)? alcoholDetected,
    TResult? Function(int durationMs)? distractionDetected,
    TResult? Function(String reason, int points)? recoveryBonus,
  }) {
    return drowsyDetected?.call(ear, durationMs);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double gForce)? hardBrakeDetected,
    TResult Function(double ear, int durationMs)? fatigueDetected,
    TResult Function(double ear, int durationMs)? drowsyDetected,
    TResult Function(double similarity)? faceVerificationFailed,
    TResult Function(double confidence)? alcoholDetected,
    TResult Function(int durationMs)? distractionDetected,
    TResult Function(String reason, int points)? recoveryBonus,
    required TResult orElse(),
  }) {
    if (drowsyDetected != null) {
      return drowsyDetected(ear, durationMs);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HardBrakeDetected value) hardBrakeDetected,
    required TResult Function(FatigueDetected value) fatigueDetected,
    required TResult Function(DrowsyDetected value) drowsyDetected,
    required TResult Function(FaceVerificationFailed value)
    faceVerificationFailed,
    required TResult Function(AlcoholDetected value) alcoholDetected,
    required TResult Function(DistractionDetected value) distractionDetected,
    required TResult Function(RecoveryBonus value) recoveryBonus,
  }) {
    return drowsyDetected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult? Function(FatigueDetected value)? fatigueDetected,
    TResult? Function(DrowsyDetected value)? drowsyDetected,
    TResult? Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult? Function(AlcoholDetected value)? alcoholDetected,
    TResult? Function(DistractionDetected value)? distractionDetected,
    TResult? Function(RecoveryBonus value)? recoveryBonus,
  }) {
    return drowsyDetected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult Function(FatigueDetected value)? fatigueDetected,
    TResult Function(DrowsyDetected value)? drowsyDetected,
    TResult Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult Function(AlcoholDetected value)? alcoholDetected,
    TResult Function(DistractionDetected value)? distractionDetected,
    TResult Function(RecoveryBonus value)? recoveryBonus,
    required TResult orElse(),
  }) {
    if (drowsyDetected != null) {
      return drowsyDetected(this);
    }
    return orElse();
  }
}

abstract class DrowsyDetected implements DrivingEvent {
  const factory DrowsyDetected({
    required final double ear,
    required final int durationMs,
  }) = _$DrowsyDetectedImpl;

  double get ear;
  int get durationMs;

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DrowsyDetectedImplCopyWith<_$DrowsyDetectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FaceVerificationFailedImplCopyWith<$Res> {
  factory _$$FaceVerificationFailedImplCopyWith(
    _$FaceVerificationFailedImpl value,
    $Res Function(_$FaceVerificationFailedImpl) then,
  ) = __$$FaceVerificationFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double similarity});
}

/// @nodoc
class __$$FaceVerificationFailedImplCopyWithImpl<$Res>
    extends _$DrivingEventCopyWithImpl<$Res, _$FaceVerificationFailedImpl>
    implements _$$FaceVerificationFailedImplCopyWith<$Res> {
  __$$FaceVerificationFailedImplCopyWithImpl(
    _$FaceVerificationFailedImpl _value,
    $Res Function(_$FaceVerificationFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? similarity = null}) {
    return _then(
      _$FaceVerificationFailedImpl(
        similarity: null == similarity
            ? _value.similarity
            : similarity // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$FaceVerificationFailedImpl implements FaceVerificationFailed {
  const _$FaceVerificationFailedImpl({this.similarity = 0.0});

  @override
  @JsonKey()
  final double similarity;

  @override
  String toString() {
    return 'DrivingEvent.faceVerificationFailed(similarity: $similarity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaceVerificationFailedImpl &&
            (identical(other.similarity, similarity) ||
                other.similarity == similarity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, similarity);

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FaceVerificationFailedImplCopyWith<_$FaceVerificationFailedImpl>
  get copyWith =>
      __$$FaceVerificationFailedImplCopyWithImpl<_$FaceVerificationFailedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double gForce) hardBrakeDetected,
    required TResult Function(double ear, int durationMs) fatigueDetected,
    required TResult Function(double ear, int durationMs) drowsyDetected,
    required TResult Function(double similarity) faceVerificationFailed,
    required TResult Function(double confidence) alcoholDetected,
    required TResult Function(int durationMs) distractionDetected,
    required TResult Function(String reason, int points) recoveryBonus,
  }) {
    return faceVerificationFailed(similarity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double gForce)? hardBrakeDetected,
    TResult? Function(double ear, int durationMs)? fatigueDetected,
    TResult? Function(double ear, int durationMs)? drowsyDetected,
    TResult? Function(double similarity)? faceVerificationFailed,
    TResult? Function(double confidence)? alcoholDetected,
    TResult? Function(int durationMs)? distractionDetected,
    TResult? Function(String reason, int points)? recoveryBonus,
  }) {
    return faceVerificationFailed?.call(similarity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double gForce)? hardBrakeDetected,
    TResult Function(double ear, int durationMs)? fatigueDetected,
    TResult Function(double ear, int durationMs)? drowsyDetected,
    TResult Function(double similarity)? faceVerificationFailed,
    TResult Function(double confidence)? alcoholDetected,
    TResult Function(int durationMs)? distractionDetected,
    TResult Function(String reason, int points)? recoveryBonus,
    required TResult orElse(),
  }) {
    if (faceVerificationFailed != null) {
      return faceVerificationFailed(similarity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HardBrakeDetected value) hardBrakeDetected,
    required TResult Function(FatigueDetected value) fatigueDetected,
    required TResult Function(DrowsyDetected value) drowsyDetected,
    required TResult Function(FaceVerificationFailed value)
    faceVerificationFailed,
    required TResult Function(AlcoholDetected value) alcoholDetected,
    required TResult Function(DistractionDetected value) distractionDetected,
    required TResult Function(RecoveryBonus value) recoveryBonus,
  }) {
    return faceVerificationFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult? Function(FatigueDetected value)? fatigueDetected,
    TResult? Function(DrowsyDetected value)? drowsyDetected,
    TResult? Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult? Function(AlcoholDetected value)? alcoholDetected,
    TResult? Function(DistractionDetected value)? distractionDetected,
    TResult? Function(RecoveryBonus value)? recoveryBonus,
  }) {
    return faceVerificationFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult Function(FatigueDetected value)? fatigueDetected,
    TResult Function(DrowsyDetected value)? drowsyDetected,
    TResult Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult Function(AlcoholDetected value)? alcoholDetected,
    TResult Function(DistractionDetected value)? distractionDetected,
    TResult Function(RecoveryBonus value)? recoveryBonus,
    required TResult orElse(),
  }) {
    if (faceVerificationFailed != null) {
      return faceVerificationFailed(this);
    }
    return orElse();
  }
}

abstract class FaceVerificationFailed implements DrivingEvent {
  const factory FaceVerificationFailed({final double similarity}) =
      _$FaceVerificationFailedImpl;

  double get similarity;

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FaceVerificationFailedImplCopyWith<_$FaceVerificationFailedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AlcoholDetectedImplCopyWith<$Res> {
  factory _$$AlcoholDetectedImplCopyWith(
    _$AlcoholDetectedImpl value,
    $Res Function(_$AlcoholDetectedImpl) then,
  ) = __$$AlcoholDetectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double confidence});
}

/// @nodoc
class __$$AlcoholDetectedImplCopyWithImpl<$Res>
    extends _$DrivingEventCopyWithImpl<$Res, _$AlcoholDetectedImpl>
    implements _$$AlcoholDetectedImplCopyWith<$Res> {
  __$$AlcoholDetectedImplCopyWithImpl(
    _$AlcoholDetectedImpl _value,
    $Res Function(_$AlcoholDetectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? confidence = null}) {
    return _then(
      _$AlcoholDetectedImpl(
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$AlcoholDetectedImpl implements AlcoholDetected {
  const _$AlcoholDetectedImpl({this.confidence = 1.0});

  @override
  @JsonKey()
  final double confidence;

  @override
  String toString() {
    return 'DrivingEvent.alcoholDetected(confidence: $confidence)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlcoholDetectedImpl &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence));
  }

  @override
  int get hashCode => Object.hash(runtimeType, confidence);

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlcoholDetectedImplCopyWith<_$AlcoholDetectedImpl> get copyWith =>
      __$$AlcoholDetectedImplCopyWithImpl<_$AlcoholDetectedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double gForce) hardBrakeDetected,
    required TResult Function(double ear, int durationMs) fatigueDetected,
    required TResult Function(double ear, int durationMs) drowsyDetected,
    required TResult Function(double similarity) faceVerificationFailed,
    required TResult Function(double confidence) alcoholDetected,
    required TResult Function(int durationMs) distractionDetected,
    required TResult Function(String reason, int points) recoveryBonus,
  }) {
    return alcoholDetected(confidence);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double gForce)? hardBrakeDetected,
    TResult? Function(double ear, int durationMs)? fatigueDetected,
    TResult? Function(double ear, int durationMs)? drowsyDetected,
    TResult? Function(double similarity)? faceVerificationFailed,
    TResult? Function(double confidence)? alcoholDetected,
    TResult? Function(int durationMs)? distractionDetected,
    TResult? Function(String reason, int points)? recoveryBonus,
  }) {
    return alcoholDetected?.call(confidence);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double gForce)? hardBrakeDetected,
    TResult Function(double ear, int durationMs)? fatigueDetected,
    TResult Function(double ear, int durationMs)? drowsyDetected,
    TResult Function(double similarity)? faceVerificationFailed,
    TResult Function(double confidence)? alcoholDetected,
    TResult Function(int durationMs)? distractionDetected,
    TResult Function(String reason, int points)? recoveryBonus,
    required TResult orElse(),
  }) {
    if (alcoholDetected != null) {
      return alcoholDetected(confidence);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HardBrakeDetected value) hardBrakeDetected,
    required TResult Function(FatigueDetected value) fatigueDetected,
    required TResult Function(DrowsyDetected value) drowsyDetected,
    required TResult Function(FaceVerificationFailed value)
    faceVerificationFailed,
    required TResult Function(AlcoholDetected value) alcoholDetected,
    required TResult Function(DistractionDetected value) distractionDetected,
    required TResult Function(RecoveryBonus value) recoveryBonus,
  }) {
    return alcoholDetected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult? Function(FatigueDetected value)? fatigueDetected,
    TResult? Function(DrowsyDetected value)? drowsyDetected,
    TResult? Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult? Function(AlcoholDetected value)? alcoholDetected,
    TResult? Function(DistractionDetected value)? distractionDetected,
    TResult? Function(RecoveryBonus value)? recoveryBonus,
  }) {
    return alcoholDetected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult Function(FatigueDetected value)? fatigueDetected,
    TResult Function(DrowsyDetected value)? drowsyDetected,
    TResult Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult Function(AlcoholDetected value)? alcoholDetected,
    TResult Function(DistractionDetected value)? distractionDetected,
    TResult Function(RecoveryBonus value)? recoveryBonus,
    required TResult orElse(),
  }) {
    if (alcoholDetected != null) {
      return alcoholDetected(this);
    }
    return orElse();
  }
}

abstract class AlcoholDetected implements DrivingEvent {
  const factory AlcoholDetected({final double confidence}) =
      _$AlcoholDetectedImpl;

  double get confidence;

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlcoholDetectedImplCopyWith<_$AlcoholDetectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DistractionDetectedImplCopyWith<$Res> {
  factory _$$DistractionDetectedImplCopyWith(
    _$DistractionDetectedImpl value,
    $Res Function(_$DistractionDetectedImpl) then,
  ) = __$$DistractionDetectedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int durationMs});
}

/// @nodoc
class __$$DistractionDetectedImplCopyWithImpl<$Res>
    extends _$DrivingEventCopyWithImpl<$Res, _$DistractionDetectedImpl>
    implements _$$DistractionDetectedImplCopyWith<$Res> {
  __$$DistractionDetectedImplCopyWithImpl(
    _$DistractionDetectedImpl _value,
    $Res Function(_$DistractionDetectedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? durationMs = null}) {
    return _then(
      _$DistractionDetectedImpl(
        durationMs: null == durationMs
            ? _value.durationMs
            : durationMs // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$DistractionDetectedImpl implements DistractionDetected {
  const _$DistractionDetectedImpl({required this.durationMs});

  @override
  final int durationMs;

  @override
  String toString() {
    return 'DrivingEvent.distractionDetected(durationMs: $durationMs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DistractionDetectedImpl &&
            (identical(other.durationMs, durationMs) ||
                other.durationMs == durationMs));
  }

  @override
  int get hashCode => Object.hash(runtimeType, durationMs);

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DistractionDetectedImplCopyWith<_$DistractionDetectedImpl> get copyWith =>
      __$$DistractionDetectedImplCopyWithImpl<_$DistractionDetectedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double gForce) hardBrakeDetected,
    required TResult Function(double ear, int durationMs) fatigueDetected,
    required TResult Function(double ear, int durationMs) drowsyDetected,
    required TResult Function(double similarity) faceVerificationFailed,
    required TResult Function(double confidence) alcoholDetected,
    required TResult Function(int durationMs) distractionDetected,
    required TResult Function(String reason, int points) recoveryBonus,
  }) {
    return distractionDetected(durationMs);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double gForce)? hardBrakeDetected,
    TResult? Function(double ear, int durationMs)? fatigueDetected,
    TResult? Function(double ear, int durationMs)? drowsyDetected,
    TResult? Function(double similarity)? faceVerificationFailed,
    TResult? Function(double confidence)? alcoholDetected,
    TResult? Function(int durationMs)? distractionDetected,
    TResult? Function(String reason, int points)? recoveryBonus,
  }) {
    return distractionDetected?.call(durationMs);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double gForce)? hardBrakeDetected,
    TResult Function(double ear, int durationMs)? fatigueDetected,
    TResult Function(double ear, int durationMs)? drowsyDetected,
    TResult Function(double similarity)? faceVerificationFailed,
    TResult Function(double confidence)? alcoholDetected,
    TResult Function(int durationMs)? distractionDetected,
    TResult Function(String reason, int points)? recoveryBonus,
    required TResult orElse(),
  }) {
    if (distractionDetected != null) {
      return distractionDetected(durationMs);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HardBrakeDetected value) hardBrakeDetected,
    required TResult Function(FatigueDetected value) fatigueDetected,
    required TResult Function(DrowsyDetected value) drowsyDetected,
    required TResult Function(FaceVerificationFailed value)
    faceVerificationFailed,
    required TResult Function(AlcoholDetected value) alcoholDetected,
    required TResult Function(DistractionDetected value) distractionDetected,
    required TResult Function(RecoveryBonus value) recoveryBonus,
  }) {
    return distractionDetected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult? Function(FatigueDetected value)? fatigueDetected,
    TResult? Function(DrowsyDetected value)? drowsyDetected,
    TResult? Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult? Function(AlcoholDetected value)? alcoholDetected,
    TResult? Function(DistractionDetected value)? distractionDetected,
    TResult? Function(RecoveryBonus value)? recoveryBonus,
  }) {
    return distractionDetected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult Function(FatigueDetected value)? fatigueDetected,
    TResult Function(DrowsyDetected value)? drowsyDetected,
    TResult Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult Function(AlcoholDetected value)? alcoholDetected,
    TResult Function(DistractionDetected value)? distractionDetected,
    TResult Function(RecoveryBonus value)? recoveryBonus,
    required TResult orElse(),
  }) {
    if (distractionDetected != null) {
      return distractionDetected(this);
    }
    return orElse();
  }
}

abstract class DistractionDetected implements DrivingEvent {
  const factory DistractionDetected({required final int durationMs}) =
      _$DistractionDetectedImpl;

  int get durationMs;

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DistractionDetectedImplCopyWith<_$DistractionDetectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RecoveryBonusImplCopyWith<$Res> {
  factory _$$RecoveryBonusImplCopyWith(
    _$RecoveryBonusImpl value,
    $Res Function(_$RecoveryBonusImpl) then,
  ) = __$$RecoveryBonusImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String reason, int points});
}

/// @nodoc
class __$$RecoveryBonusImplCopyWithImpl<$Res>
    extends _$DrivingEventCopyWithImpl<$Res, _$RecoveryBonusImpl>
    implements _$$RecoveryBonusImplCopyWith<$Res> {
  __$$RecoveryBonusImplCopyWithImpl(
    _$RecoveryBonusImpl _value,
    $Res Function(_$RecoveryBonusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? reason = null, Object? points = null}) {
    return _then(
      _$RecoveryBonusImpl(
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$RecoveryBonusImpl implements RecoveryBonus {
  const _$RecoveryBonusImpl({required this.reason, required this.points});

  @override
  final String reason;
  @override
  final int points;

  @override
  String toString() {
    return 'DrivingEvent.recoveryBonus(reason: $reason, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecoveryBonusImpl &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.points, points) || other.points == points));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason, points);

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecoveryBonusImplCopyWith<_$RecoveryBonusImpl> get copyWith =>
      __$$RecoveryBonusImplCopyWithImpl<_$RecoveryBonusImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double gForce) hardBrakeDetected,
    required TResult Function(double ear, int durationMs) fatigueDetected,
    required TResult Function(double ear, int durationMs) drowsyDetected,
    required TResult Function(double similarity) faceVerificationFailed,
    required TResult Function(double confidence) alcoholDetected,
    required TResult Function(int durationMs) distractionDetected,
    required TResult Function(String reason, int points) recoveryBonus,
  }) {
    return recoveryBonus(reason, points);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double gForce)? hardBrakeDetected,
    TResult? Function(double ear, int durationMs)? fatigueDetected,
    TResult? Function(double ear, int durationMs)? drowsyDetected,
    TResult? Function(double similarity)? faceVerificationFailed,
    TResult? Function(double confidence)? alcoholDetected,
    TResult? Function(int durationMs)? distractionDetected,
    TResult? Function(String reason, int points)? recoveryBonus,
  }) {
    return recoveryBonus?.call(reason, points);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double gForce)? hardBrakeDetected,
    TResult Function(double ear, int durationMs)? fatigueDetected,
    TResult Function(double ear, int durationMs)? drowsyDetected,
    TResult Function(double similarity)? faceVerificationFailed,
    TResult Function(double confidence)? alcoholDetected,
    TResult Function(int durationMs)? distractionDetected,
    TResult Function(String reason, int points)? recoveryBonus,
    required TResult orElse(),
  }) {
    if (recoveryBonus != null) {
      return recoveryBonus(reason, points);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(HardBrakeDetected value) hardBrakeDetected,
    required TResult Function(FatigueDetected value) fatigueDetected,
    required TResult Function(DrowsyDetected value) drowsyDetected,
    required TResult Function(FaceVerificationFailed value)
    faceVerificationFailed,
    required TResult Function(AlcoholDetected value) alcoholDetected,
    required TResult Function(DistractionDetected value) distractionDetected,
    required TResult Function(RecoveryBonus value) recoveryBonus,
  }) {
    return recoveryBonus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult? Function(FatigueDetected value)? fatigueDetected,
    TResult? Function(DrowsyDetected value)? drowsyDetected,
    TResult? Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult? Function(AlcoholDetected value)? alcoholDetected,
    TResult? Function(DistractionDetected value)? distractionDetected,
    TResult? Function(RecoveryBonus value)? recoveryBonus,
  }) {
    return recoveryBonus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(HardBrakeDetected value)? hardBrakeDetected,
    TResult Function(FatigueDetected value)? fatigueDetected,
    TResult Function(DrowsyDetected value)? drowsyDetected,
    TResult Function(FaceVerificationFailed value)? faceVerificationFailed,
    TResult Function(AlcoholDetected value)? alcoholDetected,
    TResult Function(DistractionDetected value)? distractionDetected,
    TResult Function(RecoveryBonus value)? recoveryBonus,
    required TResult orElse(),
  }) {
    if (recoveryBonus != null) {
      return recoveryBonus(this);
    }
    return orElse();
  }
}

abstract class RecoveryBonus implements DrivingEvent {
  const factory RecoveryBonus({
    required final String reason,
    required final int points,
  }) = _$RecoveryBonusImpl;

  String get reason;
  int get points;

  /// Create a copy of DrivingEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecoveryBonusImplCopyWith<_$RecoveryBonusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
