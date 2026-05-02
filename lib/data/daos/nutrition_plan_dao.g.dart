// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_plan_dao.dart';

// ignore_for_file: type=lint
mixin _$NutritionPlanDaoMixin on DatabaseAccessor<AppDatabase> {
  $ClientsTable get clients => attachedDatabase.clients;
  $NutritionCalculationsTable get nutritionCalculations =>
      attachedDatabase.nutritionCalculations;
  $NutritionPlansTable get nutritionPlans => attachedDatabase.nutritionPlans;
  NutritionPlanDaoManager get managers => NutritionPlanDaoManager(this);
}

class NutritionPlanDaoManager {
  final _$NutritionPlanDaoMixin _db;
  NutritionPlanDaoManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db.attachedDatabase, _db.clients);
  $$NutritionCalculationsTableTableManager get nutritionCalculations =>
      $$NutritionCalculationsTableTableManager(
        _db.attachedDatabase,
        _db.nutritionCalculations,
      );
  $$NutritionPlansTableTableManager get nutritionPlans =>
      $$NutritionPlansTableTableManager(
        _db.attachedDatabase,
        _db.nutritionPlans,
      );
}
