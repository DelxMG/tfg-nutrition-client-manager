/// Calculates Body Mass Index (BMI) from height and weight.
///
/// Pure domain logic — no Flutter, no Drift dependencies.
///
/// Returns null if either value is missing or height is zero.
double? calculateBmi({required int? heightCm, required double? weightKg}) {
  if (heightCm == null || weightKg == null || heightCm == 0) return null;
  final heightM = heightCm / 100.0;
  return weightKg / (heightM * heightM);
}
