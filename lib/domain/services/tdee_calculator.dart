import 'package:nutritrack/domain/enums.dart';

/// Returns the Physical Activity Level (PAL) multiplier for a given activity.
double activityFactorFor(PhysicalActivity activity) {
  return switch (activity) {
    PhysicalActivity.sedentary => 1.200,
    PhysicalActivity.light     => 1.375,
    PhysicalActivity.moderate  => 1.550,
    PhysicalActivity.active    => 1.725,
    PhysicalActivity.veryActive => 1.900,
  };
}

/// Calculates Total Daily Energy Expenditure (TDEE) as BMR × activity factor.
///
/// Returns null if bmr is null or activity is null.
double? calculateTdee({
  required double? bmr,
  required PhysicalActivity? activity,
}) {
  if (bmr == null || activity == null) return null;
  return bmr * activityFactorFor(activity);
}
