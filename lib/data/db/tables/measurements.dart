import 'package:drift/drift.dart';

import 'clients.dart';

class Measurements extends Table {
  IntColumn get measurementId => integer().autoIncrement()();

  IntColumn get clientId => integer().references(Clients, #clientId)();

  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();

  RealColumn get weight => real().nullable()();

  RealColumn get bodyFat => real().nullable()();

  RealColumn get muscleMass => real().nullable()();

  RealColumn get arm => real().nullable()();

  RealColumn get thigh => real().nullable()();

  RealColumn get chest => real().nullable()();

  RealColumn get waist => real().nullable()();

  RealColumn get calf => real().nullable()();
}
