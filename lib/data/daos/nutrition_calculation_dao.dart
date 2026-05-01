import 'package:drift/drift.dart';
import 'package:nutritrack/domain/enums.dart';

import '../db/app_database.dart';
import '../db/tables/nutrition_calculations.dart';

part 'nutrition_calculation_dao.g.dart';

@DriftAccessor(tables: [NutritionCalculations])
class NutritionCalculationDao extends DatabaseAccessor<AppDatabase>
    with _$NutritionCalculationDaoMixin {
  NutritionCalculationDao(super.db);

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
  }) {
    return into(nutritionCalculations).insert(
      NutritionCalculationsCompanion.insert(
        clientId: clientId,
        goalType: goalType,
        bmrFormula: Value(bmrFormula),
        bmr: bmr,
        tdee: tdee,
        kcalTarget: kcalTarget,
        proteins: proteins,
        carbohydrates: carbohydrates,
        fats: fats,
        date: Value(date ?? DateTime.now()),
        weightUsed: Value(weightUsed),
        heightUsed: Value(heightUsed),
        ageUsed: Value(ageUsed),
        activityFactor: Value(activityFactor),
        proteinPerKg: Value(proteinPerKg),
        fatPerKg: Value(fatPerKg),
      ),
    );
  }

  Future<int> deleteCalculation(int calculationId) {
    return (delete(nutritionCalculations)
          ..where((tbl) => tbl.calculationId.equals(calculationId)))
        .go();
  }

  Stream<List<NutritionCalculation>> watchCalculationsByClientId(int clientId) {
    return (select(nutritionCalculations)
          ..where((tbl) => tbl.clientId.equals(clientId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]))
        .watch();
  }

  Future<NutritionCalculation?> getLatestCalculationByClientId(int clientId) {
    return (select(nutritionCalculations)
          ..where((tbl) => tbl.clientId.equals(clientId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)])
          ..limit(1))
        .getSingleOrNull();
  }
}
