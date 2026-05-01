import 'package:drift/drift.dart';
import 'package:nutritrack/domain/enums.dart';

import 'clients.dart';

class Notes extends Table {
  IntColumn get noteId => integer().autoIncrement()();
  IntColumn get clientId => integer().references(Clients, #clientId)();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  IntColumn get type => intEnum<NoteType>()
      .withDefault(Constant(NoteType.general.index))();
  TextColumn get content => text()();
}
