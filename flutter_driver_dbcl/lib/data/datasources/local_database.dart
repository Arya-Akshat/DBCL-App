import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'local_database.g.dart';

class Trips extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get driverId => text()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  IntColumn get startScore => integer()();
  IntColumn get endScore => integer().nullable()();
  TextColumn get endReason => text().nullable()();
}

class DrivingEvents extends Table {
  TextColumn get id => text()();
  TextColumn get driverId => text()();
  IntColumn get tripId => integer().nullable().references(Trips, #id)();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get eventType => text()(); // FATIGUE, DROWSY, HARD_BRAKE, ALCOHOL, etc.
  IntColumn get scoreDelta => integer()();
  IntColumn get scoreBefore => integer()();
  IntColumn get scoreAfter => integer()();
  TextColumn get metadata => text()(); // JSON string

  @override
  Set<Column> get primaryKey => {id};
}

class CreditLedger extends Table {
  TextColumn get driverId => text()();
  IntColumn get currentScore => integer().withDefault(const Constant(1000))();
  DateTimeColumn get lastUpdated => dateTime()();

  @override
  Set<Column> get primaryKey => {driverId};
}

@DriftDatabase(tables: [Trips, DrivingEvents, CreditLedger])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'dbcl.sqlite'));
    return NativeDatabase(file);
  });
}
