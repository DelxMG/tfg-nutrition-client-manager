class NutritionResult {
  final double bmr;
  final double tdee;
  final double kcalTarget;
  final double proteins;
  final double fats;
  final double carbohydrates;

  const NutritionResult({
    required this.bmr,
    required this.tdee,
    required this.kcalTarget,
    required this.proteins,
    required this.fats,
    required this.carbohydrates,
  });

  double get proteinKcal => proteins * 4;
  double get fatKcal => fats * 9;
  double get carbKcal => carbohydrates * 4;

  /// False when carbohydrates go negative (protein+fat exceed kcalTarget).
  bool get isValid => carbohydrates >= 0;
}
