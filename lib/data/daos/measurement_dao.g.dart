// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_dao.dart';

// ignore_for_file: type=lint
mixin _$MeasurementDaoMixin on DatabaseAccessor<AppDatabase> {
  $ClientsTable get clients => attachedDatabase.clients;
  $MeasurementsTable get measurements => attachedDatabase.measurements;
  MeasurementDaoManager get managers => MeasurementDaoManager(this);
}

class MeasurementDaoManager {
  final _$MeasurementDaoMixin _db;
  MeasurementDaoManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db.attachedDatabase, _db.clients);
  $$MeasurementsTableTableManager get measurements =>
      $$MeasurementsTableTableManager(_db.attachedDatabase, _db.measurements);
}
