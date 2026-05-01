import 'package:drift/drift.dart';

import 'clients.dart';
import 'enums.dart';

class NutritionCalculations extends Table {
  IntColumn get calculationId => integer().autoIncrement()();

  IntColumn get clientId => integer().references(Clients, #clientId)();

  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();

  IntColumn get goalType => intEnum<GoalType>()();

  IntColumn get bmrFormula => intEnum<BmrFormula>()
      .withDefault(Constant(BmrFormula.mifflinStJeor.index))();

  // Results
  RealColumn get bmr => real()();
  RealColumn get tdee => real()();
  RealColumn get kcalTarget => real()();
  RealColumn get proteins => real()();
  RealColumn get carbohydrates => real()();
  RealColumn get fats => real()();

  // Traceability — inputs used at calculation time
  RealColumn get weightUsed => real().nullable()();
  IntColumn get heightUsed => integer().nullable()();
  IntColumn get ageUsed => integer().nullable()();
  RealColumn get activityFactor => real().nullable()();
  RealColumn get proteinPerKg => real().nullable()();
  RealColumn get fatPerKg => real().nullable()();
}
