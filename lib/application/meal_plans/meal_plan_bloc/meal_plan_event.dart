part of 'meal_plan_bloc.dart';

@immutable
sealed class MealPlanEvent {}

class GetMealPlans extends MealPlanEvent {
  final String userId;
  final DateTime startDate;
  final DateTime endDate;

  GetMealPlans(
      {required this.userId, required this.startDate, required this.endDate});
}
