import 'package:drift/drift.dart';

import 'clients.dart';
import 'enums.dart';
import 'nutrition_calculations.dart';

class NutritionPlans extends Table {
  IntColumn get planId => integer().autoIncrement()();

  IntColumn get clientId => integer().references(Clients, #clientId)();

  IntColumn get calculationId =>
      integer().references(NutritionCalculations, #calculationId)();

  TextColumn get name => text()();

  IntColumn get status => intEnum<PlanStatus>()
      .withDefault(Constant(PlanStatus.draft.index))();

  TextColumn get description => text().nullable()();

  IntColumn get mealsCount => integer().nullable()();

  RealColumn get kcalSnapshot => real().nullable()();

  IntColumn get goalType => intEnum<GoalType>().nullable()();

  TextColumn get pdfFile => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().nullable()();
}
