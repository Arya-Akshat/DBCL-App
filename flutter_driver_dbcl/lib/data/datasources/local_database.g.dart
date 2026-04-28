// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// ignore_for_file: type=lint
class $TripsTable extends Trips with TableInfo<$TripsTable, Trip> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _driverIdMeta = const VerificationMeta(
    'driverId',
  );
  @override
  late final GeneratedColumn<String> driverId = GeneratedColumn<String>(
    'driver_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startScoreMeta = const VerificationMeta(
    'startScore',
  );
  @override
  late final GeneratedColumn<int> startScore = GeneratedColumn<int>(
    'start_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endScoreMeta = const VerificationMeta(
    'endScore',
  );
  @override
  late final GeneratedColumn<int> endScore = GeneratedColumn<int>(
    'end_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endReasonMeta = const VerificationMeta(
    'endReason',
  );
  @override
  late final GeneratedColumn<String> endReason = GeneratedColumn<String>(
    'end_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    driverId,
    startTime,
    endTime,
    startScore,
    endScore,
    endReason,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trips';
  @override
  VerificationContext validateIntegrity(
    Insertable<Trip> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('driver_id')) {
      context.handle(
        _driverIdMeta,
        driverId.isAcceptableOrUnknown(data['driver_id']!, _driverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_driverIdMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('start_score')) {
      context.handle(
        _startScoreMeta,
        startScore.isAcceptableOrUnknown(data['start_score']!, _startScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_startScoreMeta);
    }
    if (data.containsKey('end_score')) {
      context.handle(
        _endScoreMeta,
        endScore.isAcceptableOrUnknown(data['end_score']!, _endScoreMeta),
      );
    }
    if (data.containsKey('end_reason')) {
      context.handle(
        _endReasonMeta,
        endReason.isAcceptableOrUnknown(data['end_reason']!, _endReasonMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trip map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trip(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      driverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}driver_id'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      startScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_score'],
      )!,
      endScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_score'],
      ),
      endReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}end_reason'],
      ),
    );
  }

  @override
  $TripsTable createAlias(String alias) {
    return $TripsTable(attachedDatabase, alias);
  }
}

class Trip extends DataClass implements Insertable<Trip> {
  final int id;
  final String driverId;
  final DateTime startTime;
  final DateTime? endTime;
  final int startScore;
  final int? endScore;
  final String? endReason;
  const Trip({
    required this.id,
    required this.driverId,
    required this.startTime,
    this.endTime,
    required this.startScore,
    this.endScore,
    this.endReason,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['driver_id'] = Variable<String>(driverId);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    map['start_score'] = Variable<int>(startScore);
    if (!nullToAbsent || endScore != null) {
      map['end_score'] = Variable<int>(endScore);
    }
    if (!nullToAbsent || endReason != null) {
      map['end_reason'] = Variable<String>(endReason);
    }
    return map;
  }

  TripsCompanion toCompanion(bool nullToAbsent) {
    return TripsCompanion(
      id: Value(id),
      driverId: Value(driverId),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      startScore: Value(startScore),
      endScore: endScore == null && nullToAbsent
          ? const Value.absent()
          : Value(endScore),
      endReason: endReason == null && nullToAbsent
          ? const Value.absent()
          : Value(endReason),
    );
  }

  factory Trip.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trip(
      id: serializer.fromJson<int>(json['id']),
      driverId: serializer.fromJson<String>(json['driverId']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      startScore: serializer.fromJson<int>(json['startScore']),
      endScore: serializer.fromJson<int?>(json['endScore']),
      endReason: serializer.fromJson<String?>(json['endReason']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'driverId': serializer.toJson<String>(driverId),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'startScore': serializer.toJson<int>(startScore),
      'endScore': serializer.toJson<int?>(endScore),
      'endReason': serializer.toJson<String?>(endReason),
    };
  }

  Trip copyWith({
    int? id,
    String? driverId,
    DateTime? startTime,
    Value<DateTime?> endTime = const Value.absent(),
    int? startScore,
    Value<int?> endScore = const Value.absent(),
    Value<String?> endReason = const Value.absent(),
  }) => Trip(
    id: id ?? this.id,
    driverId: driverId ?? this.driverId,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    startScore: startScore ?? this.startScore,
    endScore: endScore.present ? endScore.value : this.endScore,
    endReason: endReason.present ? endReason.value : this.endReason,
  );
  Trip copyWithCompanion(TripsCompanion data) {
    return Trip(
      id: data.id.present ? data.id.value : this.id,
      driverId: data.driverId.present ? data.driverId.value : this.driverId,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      startScore: data.startScore.present
          ? data.startScore.value
          : this.startScore,
      endScore: data.endScore.present ? data.endScore.value : this.endScore,
      endReason: data.endReason.present ? data.endReason.value : this.endReason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trip(')
          ..write('id: $id, ')
          ..write('driverId: $driverId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('startScore: $startScore, ')
          ..write('endScore: $endScore, ')
          ..write('endReason: $endReason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    driverId,
    startTime,
    endTime,
    startScore,
    endScore,
    endReason,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trip &&
          other.id == this.id &&
          other.driverId == this.driverId &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.startScore == this.startScore &&
          other.endScore == this.endScore &&
          other.endReason == this.endReason);
}

class TripsCompanion extends UpdateCompanion<Trip> {
  final Value<int> id;
  final Value<String> driverId;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<int> startScore;
  final Value<int?> endScore;
  final Value<String?> endReason;
  const TripsCompanion({
    this.id = const Value.absent(),
    this.driverId = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.startScore = const Value.absent(),
    this.endScore = const Value.absent(),
    this.endReason = const Value.absent(),
  });
  TripsCompanion.insert({
    this.id = const Value.absent(),
    required String driverId,
    required DateTime startTime,
    this.endTime = const Value.absent(),
    required int startScore,
    this.endScore = const Value.absent(),
    this.endReason = const Value.absent(),
  }) : driverId = Value(driverId),
       startTime = Value(startTime),
       startScore = Value(startScore);
  static Insertable<Trip> custom({
    Expression<int>? id,
    Expression<String>? driverId,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? startScore,
    Expression<int>? endScore,
    Expression<String>? endReason,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (driverId != null) 'driver_id': driverId,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (startScore != null) 'start_score': startScore,
      if (endScore != null) 'end_score': endScore,
      if (endReason != null) 'end_reason': endReason,
    });
  }

  TripsCompanion copyWith({
    Value<int>? id,
    Value<String>? driverId,
    Value<DateTime>? startTime,
    Value<DateTime?>? endTime,
    Value<int>? startScore,
    Value<int?>? endScore,
    Value<String?>? endReason,
  }) {
    return TripsCompanion(
      id: id ?? this.id,
      driverId: driverId ?? this.driverId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startScore: startScore ?? this.startScore,
      endScore: endScore ?? this.endScore,
      endReason: endReason ?? this.endReason,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (driverId.present) {
      map['driver_id'] = Variable<String>(driverId.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (startScore.present) {
      map['start_score'] = Variable<int>(startScore.value);
    }
    if (endScore.present) {
      map['end_score'] = Variable<int>(endScore.value);
    }
    if (endReason.present) {
      map['end_reason'] = Variable<String>(endReason.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripsCompanion(')
          ..write('id: $id, ')
          ..write('driverId: $driverId, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('startScore: $startScore, ')
          ..write('endScore: $endScore, ')
          ..write('endReason: $endReason')
          ..write(')'))
        .toString();
  }
}

class $DrivingEventsTable extends DrivingEvents
    with TableInfo<$DrivingEventsTable, DrivingEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DrivingEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _driverIdMeta = const VerificationMeta(
    'driverId',
  );
  @override
  late final GeneratedColumn<String> driverId = GeneratedColumn<String>(
    'driver_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<int> tripId = GeneratedColumn<int>(
    'trip_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trips (id)',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreDeltaMeta = const VerificationMeta(
    'scoreDelta',
  );
  @override
  late final GeneratedColumn<int> scoreDelta = GeneratedColumn<int>(
    'score_delta',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreBeforeMeta = const VerificationMeta(
    'scoreBefore',
  );
  @override
  late final GeneratedColumn<int> scoreBefore = GeneratedColumn<int>(
    'score_before',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreAfterMeta = const VerificationMeta(
    'scoreAfter',
  );
  @override
  late final GeneratedColumn<int> scoreAfter = GeneratedColumn<int>(
    'score_after',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metadataMeta = const VerificationMeta(
    'metadata',
  );
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
    'metadata',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    driverId,
    tripId,
    timestamp,
    eventType,
    scoreDelta,
    scoreBefore,
    scoreAfter,
    metadata,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'driving_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<DrivingEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('driver_id')) {
      context.handle(
        _driverIdMeta,
        driverId.isAcceptableOrUnknown(data['driver_id']!, _driverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_driverIdMeta);
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('score_delta')) {
      context.handle(
        _scoreDeltaMeta,
        scoreDelta.isAcceptableOrUnknown(data['score_delta']!, _scoreDeltaMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreDeltaMeta);
    }
    if (data.containsKey('score_before')) {
      context.handle(
        _scoreBeforeMeta,
        scoreBefore.isAcceptableOrUnknown(
          data['score_before']!,
          _scoreBeforeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scoreBeforeMeta);
    }
    if (data.containsKey('score_after')) {
      context.handle(
        _scoreAfterMeta,
        scoreAfter.isAcceptableOrUnknown(data['score_after']!, _scoreAfterMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreAfterMeta);
    }
    if (data.containsKey('metadata')) {
      context.handle(
        _metadataMeta,
        metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta),
      );
    } else if (isInserting) {
      context.missing(_metadataMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DrivingEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DrivingEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      driverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}driver_id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trip_id'],
      ),
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      scoreDelta: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_delta'],
      )!,
      scoreBefore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_before'],
      )!,
      scoreAfter: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_after'],
      )!,
      metadata: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metadata'],
      )!,
    );
  }

  @override
  $DrivingEventsTable createAlias(String alias) {
    return $DrivingEventsTable(attachedDatabase, alias);
  }
}

class DrivingEvent extends DataClass implements Insertable<DrivingEvent> {
  final String id;
  final String driverId;
  final int? tripId;
  final DateTime timestamp;
  final String eventType;
  final int scoreDelta;
  final int scoreBefore;
  final int scoreAfter;
  final String metadata;
  const DrivingEvent({
    required this.id,
    required this.driverId,
    this.tripId,
    required this.timestamp,
    required this.eventType,
    required this.scoreDelta,
    required this.scoreBefore,
    required this.scoreAfter,
    required this.metadata,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['driver_id'] = Variable<String>(driverId);
    if (!nullToAbsent || tripId != null) {
      map['trip_id'] = Variable<int>(tripId);
    }
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['event_type'] = Variable<String>(eventType);
    map['score_delta'] = Variable<int>(scoreDelta);
    map['score_before'] = Variable<int>(scoreBefore);
    map['score_after'] = Variable<int>(scoreAfter);
    map['metadata'] = Variable<String>(metadata);
    return map;
  }

  DrivingEventsCompanion toCompanion(bool nullToAbsent) {
    return DrivingEventsCompanion(
      id: Value(id),
      driverId: Value(driverId),
      tripId: tripId == null && nullToAbsent
          ? const Value.absent()
          : Value(tripId),
      timestamp: Value(timestamp),
      eventType: Value(eventType),
      scoreDelta: Value(scoreDelta),
      scoreBefore: Value(scoreBefore),
      scoreAfter: Value(scoreAfter),
      metadata: Value(metadata),
    );
  }

  factory DrivingEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DrivingEvent(
      id: serializer.fromJson<String>(json['id']),
      driverId: serializer.fromJson<String>(json['driverId']),
      tripId: serializer.fromJson<int?>(json['tripId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      eventType: serializer.fromJson<String>(json['eventType']),
      scoreDelta: serializer.fromJson<int>(json['scoreDelta']),
      scoreBefore: serializer.fromJson<int>(json['scoreBefore']),
      scoreAfter: serializer.fromJson<int>(json['scoreAfter']),
      metadata: serializer.fromJson<String>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'driverId': serializer.toJson<String>(driverId),
      'tripId': serializer.toJson<int?>(tripId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'eventType': serializer.toJson<String>(eventType),
      'scoreDelta': serializer.toJson<int>(scoreDelta),
      'scoreBefore': serializer.toJson<int>(scoreBefore),
      'scoreAfter': serializer.toJson<int>(scoreAfter),
      'metadata': serializer.toJson<String>(metadata),
    };
  }

  DrivingEvent copyWith({
    String? id,
    String? driverId,
    Value<int?> tripId = const Value.absent(),
    DateTime? timestamp,
    String? eventType,
    int? scoreDelta,
    int? scoreBefore,
    int? scoreAfter,
    String? metadata,
  }) => DrivingEvent(
    id: id ?? this.id,
    driverId: driverId ?? this.driverId,
    tripId: tripId.present ? tripId.value : this.tripId,
    timestamp: timestamp ?? this.timestamp,
    eventType: eventType ?? this.eventType,
    scoreDelta: scoreDelta ?? this.scoreDelta,
    scoreBefore: scoreBefore ?? this.scoreBefore,
    scoreAfter: scoreAfter ?? this.scoreAfter,
    metadata: metadata ?? this.metadata,
  );
  DrivingEvent copyWithCompanion(DrivingEventsCompanion data) {
    return DrivingEvent(
      id: data.id.present ? data.id.value : this.id,
      driverId: data.driverId.present ? data.driverId.value : this.driverId,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      scoreDelta: data.scoreDelta.present
          ? data.scoreDelta.value
          : this.scoreDelta,
      scoreBefore: data.scoreBefore.present
          ? data.scoreBefore.value
          : this.scoreBefore,
      scoreAfter: data.scoreAfter.present
          ? data.scoreAfter.value
          : this.scoreAfter,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DrivingEvent(')
          ..write('id: $id, ')
          ..write('driverId: $driverId, ')
          ..write('tripId: $tripId, ')
          ..write('timestamp: $timestamp, ')
          ..write('eventType: $eventType, ')
          ..write('scoreDelta: $scoreDelta, ')
          ..write('scoreBefore: $scoreBefore, ')
          ..write('scoreAfter: $scoreAfter, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    driverId,
    tripId,
    timestamp,
    eventType,
    scoreDelta,
    scoreBefore,
    scoreAfter,
    metadata,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DrivingEvent &&
          other.id == this.id &&
          other.driverId == this.driverId &&
          other.tripId == this.tripId &&
          other.timestamp == this.timestamp &&
          other.eventType == this.eventType &&
          other.scoreDelta == this.scoreDelta &&
          other.scoreBefore == this.scoreBefore &&
          other.scoreAfter == this.scoreAfter &&
          other.metadata == this.metadata);
}

class DrivingEventsCompanion extends UpdateCompanion<DrivingEvent> {
  final Value<String> id;
  final Value<String> driverId;
  final Value<int?> tripId;
  final Value<DateTime> timestamp;
  final Value<String> eventType;
  final Value<int> scoreDelta;
  final Value<int> scoreBefore;
  final Value<int> scoreAfter;
  final Value<String> metadata;
  final Value<int> rowid;
  const DrivingEventsCompanion({
    this.id = const Value.absent(),
    this.driverId = const Value.absent(),
    this.tripId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.eventType = const Value.absent(),
    this.scoreDelta = const Value.absent(),
    this.scoreBefore = const Value.absent(),
    this.scoreAfter = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DrivingEventsCompanion.insert({
    required String id,
    required String driverId,
    this.tripId = const Value.absent(),
    required DateTime timestamp,
    required String eventType,
    required int scoreDelta,
    required int scoreBefore,
    required int scoreAfter,
    required String metadata,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       driverId = Value(driverId),
       timestamp = Value(timestamp),
       eventType = Value(eventType),
       scoreDelta = Value(scoreDelta),
       scoreBefore = Value(scoreBefore),
       scoreAfter = Value(scoreAfter),
       metadata = Value(metadata);
  static Insertable<DrivingEvent> custom({
    Expression<String>? id,
    Expression<String>? driverId,
    Expression<int>? tripId,
    Expression<DateTime>? timestamp,
    Expression<String>? eventType,
    Expression<int>? scoreDelta,
    Expression<int>? scoreBefore,
    Expression<int>? scoreAfter,
    Expression<String>? metadata,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (driverId != null) 'driver_id': driverId,
      if (tripId != null) 'trip_id': tripId,
      if (timestamp != null) 'timestamp': timestamp,
      if (eventType != null) 'event_type': eventType,
      if (scoreDelta != null) 'score_delta': scoreDelta,
      if (scoreBefore != null) 'score_before': scoreBefore,
      if (scoreAfter != null) 'score_after': scoreAfter,
      if (metadata != null) 'metadata': metadata,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DrivingEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? driverId,
    Value<int?>? tripId,
    Value<DateTime>? timestamp,
    Value<String>? eventType,
    Value<int>? scoreDelta,
    Value<int>? scoreBefore,
    Value<int>? scoreAfter,
    Value<String>? metadata,
    Value<int>? rowid,
  }) {
    return DrivingEventsCompanion(
      id: id ?? this.id,
      driverId: driverId ?? this.driverId,
      tripId: tripId ?? this.tripId,
      timestamp: timestamp ?? this.timestamp,
      eventType: eventType ?? this.eventType,
      scoreDelta: scoreDelta ?? this.scoreDelta,
      scoreBefore: scoreBefore ?? this.scoreBefore,
      scoreAfter: scoreAfter ?? this.scoreAfter,
      metadata: metadata ?? this.metadata,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (driverId.present) {
      map['driver_id'] = Variable<String>(driverId.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<int>(tripId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (scoreDelta.present) {
      map['score_delta'] = Variable<int>(scoreDelta.value);
    }
    if (scoreBefore.present) {
      map['score_before'] = Variable<int>(scoreBefore.value);
    }
    if (scoreAfter.present) {
      map['score_after'] = Variable<int>(scoreAfter.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DrivingEventsCompanion(')
          ..write('id: $id, ')
          ..write('driverId: $driverId, ')
          ..write('tripId: $tripId, ')
          ..write('timestamp: $timestamp, ')
          ..write('eventType: $eventType, ')
          ..write('scoreDelta: $scoreDelta, ')
          ..write('scoreBefore: $scoreBefore, ')
          ..write('scoreAfter: $scoreAfter, ')
          ..write('metadata: $metadata, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CreditLedgerTable extends CreditLedger
    with TableInfo<$CreditLedgerTable, CreditLedgerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreditLedgerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _driverIdMeta = const VerificationMeta(
    'driverId',
  );
  @override
  late final GeneratedColumn<String> driverId = GeneratedColumn<String>(
    'driver_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentScoreMeta = const VerificationMeta(
    'currentScore',
  );
  @override
  late final GeneratedColumn<int> currentScore = GeneratedColumn<int>(
    'current_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1000),
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [driverId, currentScore, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'credit_ledger';
  @override
  VerificationContext validateIntegrity(
    Insertable<CreditLedgerData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('driver_id')) {
      context.handle(
        _driverIdMeta,
        driverId.isAcceptableOrUnknown(data['driver_id']!, _driverIdMeta),
      );
    } else if (isInserting) {
      context.missing(_driverIdMeta);
    }
    if (data.containsKey('current_score')) {
      context.handle(
        _currentScoreMeta,
        currentScore.isAcceptableOrUnknown(
          data['current_score']!,
          _currentScoreMeta,
        ),
      );
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {driverId};
  @override
  CreditLedgerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CreditLedgerData(
      driverId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}driver_id'],
      )!,
      currentScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_score'],
      )!,
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      )!,
    );
  }

  @override
  $CreditLedgerTable createAlias(String alias) {
    return $CreditLedgerTable(attachedDatabase, alias);
  }
}

class CreditLedgerData extends DataClass
    implements Insertable<CreditLedgerData> {
  final String driverId;
  final int currentScore;
  final DateTime lastUpdated;
  const CreditLedgerData({
    required this.driverId,
    required this.currentScore,
    required this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['driver_id'] = Variable<String>(driverId);
    map['current_score'] = Variable<int>(currentScore);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  CreditLedgerCompanion toCompanion(bool nullToAbsent) {
    return CreditLedgerCompanion(
      driverId: Value(driverId),
      currentScore: Value(currentScore),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory CreditLedgerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CreditLedgerData(
      driverId: serializer.fromJson<String>(json['driverId']),
      currentScore: serializer.fromJson<int>(json['currentScore']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'driverId': serializer.toJson<String>(driverId),
      'currentScore': serializer.toJson<int>(currentScore),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  CreditLedgerData copyWith({
    String? driverId,
    int? currentScore,
    DateTime? lastUpdated,
  }) => CreditLedgerData(
    driverId: driverId ?? this.driverId,
    currentScore: currentScore ?? this.currentScore,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
  CreditLedgerData copyWithCompanion(CreditLedgerCompanion data) {
    return CreditLedgerData(
      driverId: data.driverId.present ? data.driverId.value : this.driverId,
      currentScore: data.currentScore.present
          ? data.currentScore.value
          : this.currentScore,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CreditLedgerData(')
          ..write('driverId: $driverId, ')
          ..write('currentScore: $currentScore, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(driverId, currentScore, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CreditLedgerData &&
          other.driverId == this.driverId &&
          other.currentScore == this.currentScore &&
          other.lastUpdated == this.lastUpdated);
}

class CreditLedgerCompanion extends UpdateCompanion<CreditLedgerData> {
  final Value<String> driverId;
  final Value<int> currentScore;
  final Value<DateTime> lastUpdated;
  final Value<int> rowid;
  const CreditLedgerCompanion({
    this.driverId = const Value.absent(),
    this.currentScore = const Value.absent(),
    this.lastUpdated = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CreditLedgerCompanion.insert({
    required String driverId,
    this.currentScore = const Value.absent(),
    required DateTime lastUpdated,
    this.rowid = const Value.absent(),
  }) : driverId = Value(driverId),
       lastUpdated = Value(lastUpdated);
  static Insertable<CreditLedgerData> custom({
    Expression<String>? driverId,
    Expression<int>? currentScore,
    Expression<DateTime>? lastUpdated,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (driverId != null) 'driver_id': driverId,
      if (currentScore != null) 'current_score': currentScore,
      if (lastUpdated != null) 'last_updated': lastUpdated,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CreditLedgerCompanion copyWith({
    Value<String>? driverId,
    Value<int>? currentScore,
    Value<DateTime>? lastUpdated,
    Value<int>? rowid,
  }) {
    return CreditLedgerCompanion(
      driverId: driverId ?? this.driverId,
      currentScore: currentScore ?? this.currentScore,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (driverId.present) {
      map['driver_id'] = Variable<String>(driverId.value);
    }
    if (currentScore.present) {
      map['current_score'] = Variable<int>(currentScore.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreditLedgerCompanion(')
          ..write('driverId: $driverId, ')
          ..write('currentScore: $currentScore, ')
          ..write('lastUpdated: $lastUpdated, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TripsTable trips = $TripsTable(this);
  late final $DrivingEventsTable drivingEvents = $DrivingEventsTable(this);
  late final $CreditLedgerTable creditLedger = $CreditLedgerTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    trips,
    drivingEvents,
    creditLedger,
  ];
}

typedef $$TripsTableCreateCompanionBuilder =
    TripsCompanion Function({
      Value<int> id,
      required String driverId,
      required DateTime startTime,
      Value<DateTime?> endTime,
      required int startScore,
      Value<int?> endScore,
      Value<String?> endReason,
    });
typedef $$TripsTableUpdateCompanionBuilder =
    TripsCompanion Function({
      Value<int> id,
      Value<String> driverId,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
      Value<int> startScore,
      Value<int?> endScore,
      Value<String?> endReason,
    });

final class $$TripsTableReferences
    extends BaseReferences<_$AppDatabase, $TripsTable, Trip> {
  $$TripsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DrivingEventsTable, List<DrivingEvent>>
  _drivingEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.drivingEvents,
    aliasName: $_aliasNameGenerator(db.trips.id, db.drivingEvents.tripId),
  );

  $$DrivingEventsTableProcessedTableManager get drivingEventsRefs {
    final manager = $$DrivingEventsTableTableManager(
      $_db,
      $_db.drivingEvents,
    ).filter((f) => f.tripId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_drivingEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TripsTableFilterComposer extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get driverId => $composableBuilder(
    column: $table.driverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startScore => $composableBuilder(
    column: $table.startScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endScore => $composableBuilder(
    column: $table.endScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endReason => $composableBuilder(
    column: $table.endReason,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> drivingEventsRefs(
    Expression<bool> Function($$DrivingEventsTableFilterComposer f) f,
  ) {
    final $$DrivingEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.drivingEvents,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrivingEventsTableFilterComposer(
            $db: $db,
            $table: $db.drivingEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TripsTableOrderingComposer
    extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get driverId => $composableBuilder(
    column: $table.driverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startScore => $composableBuilder(
    column: $table.startScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endScore => $composableBuilder(
    column: $table.endScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endReason => $composableBuilder(
    column: $table.endReason,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TripsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get driverId =>
      $composableBuilder(column: $table.driverId, builder: (column) => column);

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get startScore => $composableBuilder(
    column: $table.startScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endScore =>
      $composableBuilder(column: $table.endScore, builder: (column) => column);

  GeneratedColumn<String> get endReason =>
      $composableBuilder(column: $table.endReason, builder: (column) => column);

  Expression<T> drivingEventsRefs<T extends Object>(
    Expression<T> Function($$DrivingEventsTableAnnotationComposer a) f,
  ) {
    final $$DrivingEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.drivingEvents,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DrivingEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.drivingEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TripsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TripsTable,
          Trip,
          $$TripsTableFilterComposer,
          $$TripsTableOrderingComposer,
          $$TripsTableAnnotationComposer,
          $$TripsTableCreateCompanionBuilder,
          $$TripsTableUpdateCompanionBuilder,
          (Trip, $$TripsTableReferences),
          Trip,
          PrefetchHooks Function({bool drivingEventsRefs})
        > {
  $$TripsTableTableManager(_$AppDatabase db, $TripsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TripsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TripsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TripsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> driverId = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<int> startScore = const Value.absent(),
                Value<int?> endScore = const Value.absent(),
                Value<String?> endReason = const Value.absent(),
              }) => TripsCompanion(
                id: id,
                driverId: driverId,
                startTime: startTime,
                endTime: endTime,
                startScore: startScore,
                endScore: endScore,
                endReason: endReason,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String driverId,
                required DateTime startTime,
                Value<DateTime?> endTime = const Value.absent(),
                required int startScore,
                Value<int?> endScore = const Value.absent(),
                Value<String?> endReason = const Value.absent(),
              }) => TripsCompanion.insert(
                id: id,
                driverId: driverId,
                startTime: startTime,
                endTime: endTime,
                startScore: startScore,
                endScore: endScore,
                endReason: endReason,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TripsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({drivingEventsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (drivingEventsRefs) db.drivingEvents,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (drivingEventsRefs)
                    await $_getPrefetchedData<Trip, $TripsTable, DrivingEvent>(
                      currentTable: table,
                      referencedTable: $$TripsTableReferences
                          ._drivingEventsRefsTable(db),
                      managerFromTypedResult: (p0) => $$TripsTableReferences(
                        db,
                        table,
                        p0,
                      ).drivingEventsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.tripId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TripsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TripsTable,
      Trip,
      $$TripsTableFilterComposer,
      $$TripsTableOrderingComposer,
      $$TripsTableAnnotationComposer,
      $$TripsTableCreateCompanionBuilder,
      $$TripsTableUpdateCompanionBuilder,
      (Trip, $$TripsTableReferences),
      Trip,
      PrefetchHooks Function({bool drivingEventsRefs})
    >;
typedef $$DrivingEventsTableCreateCompanionBuilder =
    DrivingEventsCompanion Function({
      required String id,
      required String driverId,
      Value<int?> tripId,
      required DateTime timestamp,
      required String eventType,
      required int scoreDelta,
      required int scoreBefore,
      required int scoreAfter,
      required String metadata,
      Value<int> rowid,
    });
typedef $$DrivingEventsTableUpdateCompanionBuilder =
    DrivingEventsCompanion Function({
      Value<String> id,
      Value<String> driverId,
      Value<int?> tripId,
      Value<DateTime> timestamp,
      Value<String> eventType,
      Value<int> scoreDelta,
      Value<int> scoreBefore,
      Value<int> scoreAfter,
      Value<String> metadata,
      Value<int> rowid,
    });

final class $$DrivingEventsTableReferences
    extends BaseReferences<_$AppDatabase, $DrivingEventsTable, DrivingEvent> {
  $$DrivingEventsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TripsTable _tripIdTable(_$AppDatabase db) => db.trips.createAlias(
    $_aliasNameGenerator(db.drivingEvents.tripId, db.trips.id),
  );

  $$TripsTableProcessedTableManager? get tripId {
    final $_column = $_itemColumn<int>('trip_id');
    if ($_column == null) return null;
    final manager = $$TripsTableTableManager(
      $_db,
      $_db.trips,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tripIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DrivingEventsTableFilterComposer
    extends Composer<_$AppDatabase, $DrivingEventsTable> {
  $$DrivingEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get driverId => $composableBuilder(
    column: $table.driverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreDelta => $composableBuilder(
    column: $table.scoreDelta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreBefore => $composableBuilder(
    column: $table.scoreBefore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreAfter => $composableBuilder(
    column: $table.scoreAfter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnFilters(column),
  );

  $$TripsTableFilterComposer get tripId {
    final $$TripsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableFilterComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DrivingEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $DrivingEventsTable> {
  $$DrivingEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get driverId => $composableBuilder(
    column: $table.driverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreDelta => $composableBuilder(
    column: $table.scoreDelta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreBefore => $composableBuilder(
    column: $table.scoreBefore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreAfter => $composableBuilder(
    column: $table.scoreAfter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metadata => $composableBuilder(
    column: $table.metadata,
    builder: (column) => ColumnOrderings(column),
  );

  $$TripsTableOrderingComposer get tripId {
    final $$TripsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableOrderingComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DrivingEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DrivingEventsTable> {
  $$DrivingEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get driverId =>
      $composableBuilder(column: $table.driverId, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<int> get scoreDelta => $composableBuilder(
    column: $table.scoreDelta,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scoreBefore => $composableBuilder(
    column: $table.scoreBefore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get scoreAfter => $composableBuilder(
    column: $table.scoreAfter,
    builder: (column) => column,
  );

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  $$TripsTableAnnotationComposer get tripId {
    final $$TripsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableAnnotationComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DrivingEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DrivingEventsTable,
          DrivingEvent,
          $$DrivingEventsTableFilterComposer,
          $$DrivingEventsTableOrderingComposer,
          $$DrivingEventsTableAnnotationComposer,
          $$DrivingEventsTableCreateCompanionBuilder,
          $$DrivingEventsTableUpdateCompanionBuilder,
          (DrivingEvent, $$DrivingEventsTableReferences),
          DrivingEvent,
          PrefetchHooks Function({bool tripId})
        > {
  $$DrivingEventsTableTableManager(_$AppDatabase db, $DrivingEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DrivingEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DrivingEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DrivingEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> driverId = const Value.absent(),
                Value<int?> tripId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<int> scoreDelta = const Value.absent(),
                Value<int> scoreBefore = const Value.absent(),
                Value<int> scoreAfter = const Value.absent(),
                Value<String> metadata = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DrivingEventsCompanion(
                id: id,
                driverId: driverId,
                tripId: tripId,
                timestamp: timestamp,
                eventType: eventType,
                scoreDelta: scoreDelta,
                scoreBefore: scoreBefore,
                scoreAfter: scoreAfter,
                metadata: metadata,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String driverId,
                Value<int?> tripId = const Value.absent(),
                required DateTime timestamp,
                required String eventType,
                required int scoreDelta,
                required int scoreBefore,
                required int scoreAfter,
                required String metadata,
                Value<int> rowid = const Value.absent(),
              }) => DrivingEventsCompanion.insert(
                id: id,
                driverId: driverId,
                tripId: tripId,
                timestamp: timestamp,
                eventType: eventType,
                scoreDelta: scoreDelta,
                scoreBefore: scoreBefore,
                scoreAfter: scoreAfter,
                metadata: metadata,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DrivingEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tripId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tripId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tripId,
                                referencedTable: $$DrivingEventsTableReferences
                                    ._tripIdTable(db),
                                referencedColumn: $$DrivingEventsTableReferences
                                    ._tripIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DrivingEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DrivingEventsTable,
      DrivingEvent,
      $$DrivingEventsTableFilterComposer,
      $$DrivingEventsTableOrderingComposer,
      $$DrivingEventsTableAnnotationComposer,
      $$DrivingEventsTableCreateCompanionBuilder,
      $$DrivingEventsTableUpdateCompanionBuilder,
      (DrivingEvent, $$DrivingEventsTableReferences),
      DrivingEvent,
      PrefetchHooks Function({bool tripId})
    >;
typedef $$CreditLedgerTableCreateCompanionBuilder =
    CreditLedgerCompanion Function({
      required String driverId,
      Value<int> currentScore,
      required DateTime lastUpdated,
      Value<int> rowid,
    });
typedef $$CreditLedgerTableUpdateCompanionBuilder =
    CreditLedgerCompanion Function({
      Value<String> driverId,
      Value<int> currentScore,
      Value<DateTime> lastUpdated,
      Value<int> rowid,
    });

class $$CreditLedgerTableFilterComposer
    extends Composer<_$AppDatabase, $CreditLedgerTable> {
  $$CreditLedgerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get driverId => $composableBuilder(
    column: $table.driverId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentScore => $composableBuilder(
    column: $table.currentScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CreditLedgerTableOrderingComposer
    extends Composer<_$AppDatabase, $CreditLedgerTable> {
  $$CreditLedgerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get driverId => $composableBuilder(
    column: $table.driverId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentScore => $composableBuilder(
    column: $table.currentScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CreditLedgerTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreditLedgerTable> {
  $$CreditLedgerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get driverId =>
      $composableBuilder(column: $table.driverId, builder: (column) => column);

  GeneratedColumn<int> get currentScore => $composableBuilder(
    column: $table.currentScore,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );
}

class $$CreditLedgerTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreditLedgerTable,
          CreditLedgerData,
          $$CreditLedgerTableFilterComposer,
          $$CreditLedgerTableOrderingComposer,
          $$CreditLedgerTableAnnotationComposer,
          $$CreditLedgerTableCreateCompanionBuilder,
          $$CreditLedgerTableUpdateCompanionBuilder,
          (
            CreditLedgerData,
            BaseReferences<_$AppDatabase, $CreditLedgerTable, CreditLedgerData>,
          ),
          CreditLedgerData,
          PrefetchHooks Function()
        > {
  $$CreditLedgerTableTableManager(_$AppDatabase db, $CreditLedgerTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreditLedgerTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreditLedgerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreditLedgerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> driverId = const Value.absent(),
                Value<int> currentScore = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CreditLedgerCompanion(
                driverId: driverId,
                currentScore: currentScore,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String driverId,
                Value<int> currentScore = const Value.absent(),
                required DateTime lastUpdated,
                Value<int> rowid = const Value.absent(),
              }) => CreditLedgerCompanion.insert(
                driverId: driverId,
                currentScore: currentScore,
                lastUpdated: lastUpdated,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CreditLedgerTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreditLedgerTable,
      CreditLedgerData,
      $$CreditLedgerTableFilterComposer,
      $$CreditLedgerTableOrderingComposer,
      $$CreditLedgerTableAnnotationComposer,
      $$CreditLedgerTableCreateCompanionBuilder,
      $$CreditLedgerTableUpdateCompanionBuilder,
      (
        CreditLedgerData,
        BaseReferences<_$AppDatabase, $CreditLedgerTable, CreditLedgerData>,
      ),
      CreditLedgerData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TripsTableTableManager get trips =>
      $$TripsTableTableManager(_db, _db.trips);
  $$DrivingEventsTableTableManager get drivingEvents =>
      $$DrivingEventsTableTableManager(_db, _db.drivingEvents);
  $$CreditLedgerTableTableManager get creditLedger =>
      $$CreditLedgerTableTableManager(_db, _db.creditLedger);
}
