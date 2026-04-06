import 'package:nutritrack/domain/enums.dart';

import '../daos/anamnesis_dao.dart';
import '../db/app_database.dart';
import '../db/tables/anamnesis.dart';

class AnamnesisRepository {
  final AnamnesisDao anamnesisDao;

  AnamnesisRepository(AppDatabase db) : anamnesisDao = AnamnesisDao(db);

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
    return anamnesisDao.insertAnamnesis(
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
  }

  Future<bool> updateAnamnesis(AnamnesisTableData anamnesis) {
    return anamnesisDao.updateAnamnesis(anamnesis);
  }

  Future<AnamnesisTableData?> getAnamnesisByClientId(int clientId) {
    return anamnesisDao.getAnamnesisByClientId(clientId);
  }

  Stream<AnamnesisTableData?> watchAnamnesisByClientId(int clientId) {
    return anamnesisDao.watchAnamnesisByClientId(clientId);
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
  }) {
    return anamnesisDao.upsertAnamnesisByClientId(
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
  }
}
