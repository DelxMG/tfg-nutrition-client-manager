import 'package:drift/drift.dart';

import '../db/app_database.dart';
import '../db/tables/measurements.dart';

part 'measurement_dao.g.dart';

@DriftAccessor(tables: [Measurements])
class MeasurementDao extends DatabaseAccessor<AppDatabase>
    with _$MeasurementDaoMixin {
  MeasurementDao(super.db);

  Future<int> insertMeasurement({
    required int clientId,
    DateTime? date,
    double? weight,
    double? bodyFat,
    double? muscleMass,
    double? arm,
    double? thigh,
    double? chest,
    double? waist,
    double? calf,
  }) {
    return into(measurements).insert(
      MeasurementsCompanion.insert(
        clientId: clientId,
        date: Value(date ?? DateTime.now()),
        weight: Value(weight),
        bodyFat: Value(bodyFat),
        muscleMass: Value(muscleMass),
        arm: Value(arm),
        thigh: Value(thigh),
        chest: Value(chest),
        waist: Value(waist),
        calf: Value(calf),
      ),
    );
  }

  Future<bool> updateMeasurement(Measurement measurement) {
    return update(measurements).replace(measurement);
  }

  Future<int> deleteMeasurement(int measurementId) {
    return (delete(measurements)
          ..where((tbl) => tbl.measurementId.equals(measurementId)))
        .go();
  }

  Future<Measurement?> getMeasurementById(int measurementId) {
    return (select(measurements)
          ..where((tbl) => tbl.measurementId.equals(measurementId)))
        .getSingleOrNull();
  }

  Stream<List<Measurement>> watchMeasurementsByClientId(int clientId) {
    return (select(measurements)
          ..where((tbl) => tbl.clientId.equals(clientId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)]))
        .watch();
  }

  Future<Measurement?> getLatestMeasurementByClientId(int clientId) {
    return (select(measurements)
          ..where((tbl) => tbl.clientId.equals(clientId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)])
          ..limit(1))
        .getSingleOrNull();
  }

  Stream<Measurement?> watchLatestMeasurementByClientId(int clientId) {
    return (select(measurements)
          ..where((tbl) => tbl.clientId.equals(clientId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)])
          ..limit(1))
        .watchSingleOrNull();
  }
}
