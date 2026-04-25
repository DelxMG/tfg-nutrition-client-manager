import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../db/tables/anamnesis.dart';
import '../db/tables/enums.dart';

part 'anamnesis_dao.g.dart';

@DriftAccessor(tables: [AnamnesisTable])
class AnamnesisDao extends DatabaseAccessor<AppDatabase>
    with _$AnamnesisDaoMixin {
  AnamnesisDao(super.db);

  Future<int> insertAnamnesis({
    required int clientId,
    DateTime? date,
    String? objective,
    double? initialWeight,
    String? observations,
    String? supplements,
    String? allergies,
    PhysicalActivity? physicalActivity,
    String? pathologies,
    String? occupation,
  }) {
    return into(anamnesisTable).insert(
      AnamnesisTableCompanion.insert(
        clientId: clientId,
        date: Value(date ?? DateTime.now()),
        objective: Value(objective),
        initialWeight: Value(initialWeight),
        observations: Value(observations),
        supplements: Value(supplements),
        allergies: Value(allergies),
        physicalActivity: Value(physicalActivity),
        pathologies: Value(pathologies),
        occupation: Value(occupation),
      ),
    );
  }

  Future<bool> updateAnamnesis(AnamnesisTableData anamnesis) {
    return update(anamnesisTable).replace(anamnesis);
  }

  Future<AnamnesisTableData?> getAnamnesisByClientId(int clientId) {
    return (select(anamnesisTable)
          ..where((tbl) => tbl.clientId.equals(clientId)))
        .getSingleOrNull();
  }

  Stream<AnamnesisTableData?> watchAnamnesisByClientId(int clientId) {
    return (select(anamnesisTable)
          ..where((tbl) => tbl.clientId.equals(clientId)))
        .watchSingleOrNull();
  }

  Future<void> upsertAnamnesisByClientId({
    required int clientId,
    DateTime? date,
    String? objective,
    double? initialWeight,
    String? observations,
    String? supplements,
    String? allergies,
    PhysicalActivity? physicalActivity,
    String? pathologies,
    String? occupation,
  }) async {
    final existing = await getAnamnesisByClientId(clientId);
    if (existing == null) {
      await insertAnamnesis(
        clientId: clientId,
        date: date,
        objective: objective,
        initialWeight: initialWeight,
        observations: observations,
        supplements: supplements,
        allergies: allergies,
        physicalActivity: physicalActivity,
        pathologies: pathologies,
        occupation: occupation,
      );
    } else {
      await updateAnamnesis(
        existing.copyWith(
          date: date ?? existing.date,
          objective: Value(objective),
          initialWeight: Value(initialWeight),
          observations: Value(observations),
          supplements: Value(supplements),
          allergies: Value(allergies),
          physicalActivity: Value(physicalActivity),
          pathologies: Value(pathologies),
          occupation: Value(occupation),
        ),
      );
    }
  }
}
