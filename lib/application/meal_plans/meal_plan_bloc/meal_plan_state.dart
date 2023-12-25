part of 'meal_plan_bloc.dart';

@immutable
sealed class MealPlanState {}

final class MealPlanInitial extends MealPlanState {}

class LoadingMealPlans extends MealPlanState {}

class MealPlanFetched extends MealPlanState {
  final Map<Day, List<MealPlan>> daywiseMealPlan;

  MealPlanFetched({required this.daywiseMealPlan});
}

class ErrorFetchingMealPlans extends MealPlanState {
  final String error;

  ErrorFetchingMealPlans({
    required this.error,
  });
}
