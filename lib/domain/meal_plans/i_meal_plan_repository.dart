// ignore_for_file: depend_on_referenced_packages

import 'package:menumaster_manager/domain/meal_plans/meal_plan.dart';
import 'package:widgets_book/widgets_book.dart';
import 'package:fpdart/fpdart.dart';

abstract class IMealPlanRepository {
  Future<Either<ApiError, List<MealPlan>>> getMealPlans({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  });
}
