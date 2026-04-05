import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:nutritrack/data/db/tables/enums.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../daos/anamnesis_dao.dart';
import '../daos/client_dao.dart';
import '../daos/measurement_dao.dart';
import 'tables/anamnesis.dart';
import 'tables/clients.dart';
import 'tables/measurements.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Clients, AnamnesisTable, Measurements],
  daos: [ClientDao, AnamnesisDao, MeasurementDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'nutritrack.db'));
    return NativeDatabase(file);
  });
}
