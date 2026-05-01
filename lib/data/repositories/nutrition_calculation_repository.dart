import 'package:nutritrack/domain/enums.dart';

import '../daos/nutrition_calculation_dao.dart';
import '../db/app_database.dart';

class NutritionCalculationRepository {
  final NutritionCalculationDao nutritionCalculationDao;

  NutritionCalculationRepository(AppDatabase db)
      : nutritionCalculationDao = NutritionCalculationDao(db);

  Future<int> insertCalculation({
    required int clientId,
    required GoalType goalType,
    required double bmr,
    required double tdee,
    required double kcalTarget,
    required double proteins,
    required double carbohydrates,
    required double fats,
    BmrFormula bmrFormula = BmrFormula.mifflinStJeor,
    DateTime? date,
    double? weightUsed,
    int? heightUsed,
    int? ageUsed,
    double? activityFactor,
    double? proteinPerKg,
    double? fatPerKg,
  }) =>
      nutritionCalculationDao.insertCalculation(
        clientId: clientId,
        goalType: goalType,
        bmr: bmr,
        tdee: tdee,
        kcalTarget: kcalTarget,
        proteins: proteins,
        carbohydrates: carbohydrates,
        fats: fats,
        bmrFormula: bmrFormula,
        date: date,
        weightUsed: weightUsed,
        heightUsed: heightUsed,
        ageUsed: ageUsed,
        activityFactor: activityFactor,
        proteinPerKg: proteinPerKg,
        fatPerKg: fatPerKg,
      );

  Future<int> deleteCalculation(int calculationId) =>
      nutritionCalculationDao.deleteCalculation(calculationId);

  Stream<List<NutritionCalculation>> watchCalculationsByClientId(int clientId) =>
      nutritionCalculationDao.watchCalculationsByClientId(clientId);

  Future<NutritionCalculation?> getLatestCalculationByClientId(int clientId) =>
      nutritionCalculationDao.getLatestCalculationByClientId(clientId);
}
