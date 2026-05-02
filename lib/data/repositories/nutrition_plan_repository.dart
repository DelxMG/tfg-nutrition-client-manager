import 'package:nutritrack/domain/enums.dart';

import '../daos/nutrition_plan_dao.dart';
import '../db/app_database.dart';

class NutritionPlanRepository {
  final NutritionPlanDao nutritionPlanDao;

  NutritionPlanRepository(AppDatabase db)
      : nutritionPlanDao = NutritionPlanDao(db);

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
  }) =>
      nutritionPlanDao.insertPlan(
        clientId: clientId,
        calculationId: calculationId,
        name: name,
        status: status,
        description: description,
        mealsCount: mealsCount,
        kcalSnapshot: kcalSnapshot,
        goalType: goalType,
        pdfFile: pdfFile,
      );

  Future<int> updatePlan(
    int planId, {
    String? name,
    PlanStatus? status,
    String? description,
    int? mealsCount,
    String? pdfFile,
  }) =>
      nutritionPlanDao.updatePlan(
        planId,
        name: name,
        status: status,
        description: description,
        mealsCount: mealsCount,
        pdfFile: pdfFile,
      );

  Future<int> deletePlan(int planId) =>
      nutritionPlanDao.deletePlan(planId);

  Stream<List<NutritionPlan>> watchPlansByClientId(int clientId) =>
      nutritionPlanDao.watchPlansByClientId(clientId);

  Future<NutritionPlan?> getPlanById(int planId) =>
      nutritionPlanDao.getPlanById(planId);
}
