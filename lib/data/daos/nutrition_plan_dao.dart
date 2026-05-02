import 'package:drift/drift.dart';
import 'package:nutritrack/domain/enums.dart';

import '../db/app_database.dart';
import '../db/tables/nutrition_plans.dart';

part 'nutrition_plan_dao.g.dart';

@DriftAccessor(tables: [NutritionPlans])
class NutritionPlanDao extends DatabaseAccessor<AppDatabase>
    with _$NutritionPlanDaoMixin {
  NutritionPlanDao(super.db);

  Future<int> insertPlan({
    required int clientId,
    int? calculationId,
    required String name,
    PlanStatus status = PlanStatus.draft,
    String? description,
    int? mealsCount,
    double? kcalSnapshot,
    GoalType? goalType,
    String? pdfFile,
  }) {
    return into(nutritionPlans).insert(
      NutritionPlansCompanion.insert(
        clientId: clientId,
        calculationId: Value(calculationId),
        name: name,
        status: Value(status),
        description: Value(description),
        mealsCount: Value(mealsCount),
        kcalSnapshot: Value(kcalSnapshot),
        goalType: Value(goalType),
        pdfFile: Value(pdfFile),
      ),
    );
  }

  Future<int> updatePlan(
    int planId, {
    String? name,
    PlanStatus? status,
    String? description,
    int? mealsCount,
    double? kcalSnapshot,
    String? pdfFile,
  }) {
    return (update(nutritionPlans)
          ..where((tbl) => tbl.planId.equals(planId)))
        .write(
      NutritionPlansCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        status: status != null ? Value(status) : const Value.absent(),
        description:
            description != null ? Value(description) : const Value.absent(),
        mealsCount:
            mealsCount != null ? Value(mealsCount) : const Value.absent(),
        kcalSnapshot:
            kcalSnapshot != null ? Value(kcalSnapshot) : const Value.absent(),
        pdfFile: pdfFile != null ? Value(pdfFile) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> deletePlan(int planId) {
    return (delete(nutritionPlans)
          ..where((tbl) => tbl.planId.equals(planId)))
        .go();
  }

  Stream<List<NutritionPlan>> watchPlansByClientId(int clientId) {
    return (select(nutritionPlans)
          ..where((tbl) => tbl.clientId.equals(clientId))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.createdAt)]))
        .watch();
  }

  Future<NutritionPlan?> getPlanById(int planId) {
    return (select(nutritionPlans)
          ..where((tbl) => tbl.planId.equals(planId)))
        .getSingleOrNull();
  }
}
