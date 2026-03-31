import 'package:drift/drift.dart';

enum ClientStatus {
  active,
  inactive,
  pending,
}

enum Sex {
  male,
  female,
}

class Clients extends Table {
  IntColumn get clientId => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get email => text().nullable()();

  TextColumn get phone => text().nullable()();

  IntColumn get height => integer().nullable()();

  IntColumn get sex => intEnum<Sex>().nullable()();

  DateTimeColumn get birthDate => dateTime().nullable()();

  IntColumn get status =>
      intEnum<ClientStatus>().withDefault(const Constant(0))();

  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
}