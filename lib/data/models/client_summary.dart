import '../db/app_database.dart';
import '../db/tables/anamnesis.dart';
import '../db/tables/measurements.dart';

/// Aggregate of the three data sources needed to render the client detail
/// summary tab. All fields are nullable — the UI decides what to show when
/// data is absent.
class ClientSummary {
  final Client client;
  final AnamnesisTableData? anamnesis;
  final Measurement? latestMeasurement;

  const ClientSummary({
    required this.client,
    this.anamnesis,
    this.latestMeasurement,
  });

  /// Derived: BMI from client height (cm) + latest measurement weight (kg).
  /// Returns null if either value is missing.
  double? get bmi {
    final heightCm = client.height;
    final weightKg = latestMeasurement?.weight;
    if (heightCm == null || weightKg == null || heightCm == 0) return null;
    final heightM = heightCm / 100.0;
    return weightKg / (heightM * heightM);
  }

  /// Derived: date of the latest measurement, used as "last visit".
  DateTime? get lastVisit => latestMeasurement?.date;
}
