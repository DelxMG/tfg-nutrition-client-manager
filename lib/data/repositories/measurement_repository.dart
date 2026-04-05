import '../daos/measurement_dao.dart';
import '../db/app_database.dart';
import '../db/tables/measurements.dart';

class MeasurementRepository {
  final MeasurementDao measurementDao;

  MeasurementRepository(AppDatabase db) : measurementDao = MeasurementDao(db);

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
    return measurementDao.insertMeasurement(
      clientId: clientId,
      date: date,
      weight: weight,
      bodyFat: bodyFat,
      muscleMass: muscleMass,
      arm: arm,
      thigh: thigh,
      chest: chest,
      waist: waist,
      calf: calf,
    );
  }

  Future<bool> updateMeasurement(Measurement measurement) {
    return measurementDao.updateMeasurement(measurement);
  }

  Future<int> deleteMeasurement(int measurementId) {
    return measurementDao.deleteMeasurement(measurementId);
  }

  Future<Measurement?> getMeasurementById(int measurementId) {
    return measurementDao.getMeasurementById(measurementId);
  }

  Stream<List<Measurement>> watchMeasurementsByClientId(int clientId) {
    return measurementDao.watchMeasurementsByClientId(clientId);
  }

  Future<Measurement?> getLatestMeasurementByClientId(int clientId) {
    return measurementDao.getLatestMeasurementByClientId(clientId);
  }

  Stream<Measurement?> watchLatestMeasurementByClientId(int clientId) {
    return measurementDao.watchLatestMeasurementByClientId(clientId);
  }
}
