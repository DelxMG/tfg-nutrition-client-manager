import 'package:nutritrack/domain/enums.dart';
import 'package:nutritrack/domain/models/nutrition_result.dart';

/// Calculates kcal target and macro distribution from pre-computed BMR and TDEE.
///
/// Returns null if any required value is null or invalid.
NutritionResult? calculateNutrition({
  required double? bmr,
  required double? tdee,
  required GoalType goalType,
  required double? weightKg,
  double proteinPerKg = 2.0,
  double fatPerKg = 0.9,
}) {
  if (bmr == null || bmr <= 0) return null;
  if (tdee == null || tdee <= 0) return null;
  if (weightKg == null || weightKg <= 0) return null;

  final kcalTarget = switch (goalType) {
    GoalType.deficit     => tdee * 0.90,
    GoalType.maintenance => tdee,
    GoalType.surplus     => tdee * 1.10,
  };

  final proteins = weightKg * proteinPerKg;
  final fats = weightKg * fatPerKg;
  final carbohydrates = (kcalTarget - proteins * 4 - fats * 9) / 4;

  return NutritionResult(
    bmr: bmr,
    tdee: tdee,
    kcalTarget: kcalTarget,
    proteins: proteins,
    fats: fats,
    carbohydrates: carbohydrates,
  );
}
