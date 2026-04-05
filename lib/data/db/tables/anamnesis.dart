import 'package:drift/drift.dart';

import 'clients.dart';
import 'enums.dart';

class AnamnesisTable extends Table {
  @override
  String get tableName => 'anamnesis';

  IntColumn get anamnesisId => integer().autoIncrement()();

  IntColumn get clientId => integer().references(Clients, #clientId)();

  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();

  TextColumn get objective => text().nullable()();

  RealColumn get initialWeight => real().nullable()();

  TextColumn get observations => text().nullable()();

  TextColumn get supplements => text().nullable()();

  TextColumn get allergies => text().nullable()();

  IntColumn get physicalActivity => intEnum<PhysicalActivity>().nullable()();

  TextColumn get pathologies => text().nullable()();

  TextColumn get occupation => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {clientId},
      ];
}
