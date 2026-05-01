import 'package:nutritrack/domain/enums.dart';

/// Calculates Basal Metabolic Rate (BMR) using the selected formula.
///
/// Returns null if any required parameter is missing or invalid.
double? calculateBmr({
  required double? weightKg,
  required int? heightCm,
  required int? age,
  required Sex? sex,
  BmrFormula formula = BmrFormula.mifflinStJeor,
}) {
  if (weightKg == null || weightKg <= 0) return null;
  if (heightCm == null || heightCm <= 0) return null;
  if (age == null || age <= 0) return null;
  if (sex == null) return null;

  return switch (formula) {
    BmrFormula.mifflinStJeor => _mifflinStJeor(weightKg, heightCm, age, sex),
    BmrFormula.harrisBenedict => _harrisBenedict(weightKg, heightCm, age, sex),
  };
}

double _mifflinStJeor(double w, int h, int age, Sex sex) {
  final base = 10 * w + 6.25 * h - 5 * age;
  return sex == Sex.male ? base + 5 : base - 161;
}

double _harrisBenedict(double w, int h, int age, Sex sex) {
  return sex == Sex.male
      ? 88.362 + 13.397 * w + 4.799 * h - 5.677 * age
      : 447.593 + 9.247 * w + 3.098 * h - 4.330 * age;
}
