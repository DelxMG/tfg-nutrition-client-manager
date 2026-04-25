import 'package:drift/drift.dart';
import 'package:nutritrack/domain/enums.dart';

export 'package:nutritrack/domain/enums.dart' show ClientStatus, Sex;

class Clients extends Table {
  IntColumn get clientId => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get email => text().nullable()();

  TextColumn get phone => text().nullable()();

  IntColumn get height => integer().nullable()();

  IntColumn get sex => intEnum<Sex>().nullable()();

  DateTimeColumn get birthDate => dateTime().nullable()();

  IntColumn get status =>
      intEnum<ClientStatus>().withDefault(Constant(ClientStatus.active.index))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
