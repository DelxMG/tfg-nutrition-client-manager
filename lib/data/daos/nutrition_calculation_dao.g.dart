// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_calculation_dao.dart';

// ignore_for_file: type=lint
mixin _$NutritionCalculationDaoMixin on DatabaseAccessor<AppDatabase> {
  $ClientsTable get clients => attachedDatabase.clients;
  $NutritionCalculationsTable get nutritionCalculations =>
      attachedDatabase.nutritionCalculations;
  NutritionCalculationDaoManager get managers =>
      NutritionCalculationDaoManager(this);
}

class NutritionCalculationDaoManager {
  final _$NutritionCalculationDaoMixin _db;
  NutritionCalculationDaoManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db.attachedDatabase, _db.clients);
  $$NutritionCalculationsTableTableManager get nutritionCalculations =>
      $$NutritionCalculationsTableTableManager(
        _db.attachedDatabase,
        _db.nutritionCalculations,
      );
}
