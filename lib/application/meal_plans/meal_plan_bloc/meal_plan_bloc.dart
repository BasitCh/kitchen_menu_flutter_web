// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:menumaster_manager/domain/meal_plans/meal_plan.dart';
import 'package:menumaster_manager/infrastructure/meal_plan/meal_plan_repository.dart';
import 'package:meta/meta.dart';
import 'package:widgets_book/widgets_book.dart';

part 'meal_plan_event.dart';
part 'meal_plan_state.dart';

class MealPlanBloc extends Bloc<MealPlanEvent, MealPlanState> {
  final MealPlanRepository mealPlanRepository;

  MealPlanBloc({required this.mealPlanRepository}) : super(MealPlanInitial()) {
    on<GetMealPlans>(_onFetchingMealPlans);
  }

  Future<void> _onFetchingMealPlans(
      GetMealPlans event, Emitter<MealPlanState> emit) async {
    emit(LoadingMealPlans());

    final response = await mealPlanRepository.getMealPlans(
      userId: event.userId,
      startDate: event.startDate,
      endDate: event.endDate,
    );
    response.fold(
      (apiError) => emit(ErrorFetchingMealPlans(
        error: apiError.message ?? 'Failed to get meal plan',
      )),
      (mealPlans) {
        if (mealPlans.isNotEmpty) {
          final dayWiseMealPlans = getCategoryAndDayWisePlan(mealPlans);
          emit(
            MealPlanFetched(daywiseMealPlan: dayWiseMealPlans),
          );
        } else {
          emit(ErrorFetchingMealPlans(error: 'No meal plan found'));
        }
      },
    );
  }

  Map<Day, List<MealPlan>> getCategoryAndDayWisePlan(List<MealPlan> mealPlans) {
    Map<Day, List<MealPlan>> dayWiseMealPlan = {};
    List<String?> days = mealPlans.map((e) => e.day).toSet().toList();
    // List<String?> cateo .gies = mealPlans.map((e) => e.category).toSet().toList();
    List<MealPlan> plans = [];
    dayWiseMealPlan.clear();
    plans.clear();
    days.sort((a, b) =>
        _dayOrder(a?.toLowerCase() ?? '') - _dayOrder(b?.toLowerCase() ?? ''));
    for (String? day in days) {
      final list = mealPlans.where((element) => element.day == day).toList();
      // Sort the list of days using Intl.compare

      dayWiseMealPlan[Day(day: day!)] = list;
    }
    return dayWiseMealPlan;
  }

  int _dayOrder(String day) {
    final Map<String, int> dayOrder = {
      'monday': 1,
      'tuesday': 2,
      'wednesday': 3,
      'thursday': 4,
      'friday': 5,
      'saturday': 6,
      'sunday': 7,
    };

    // Return the order of the given day
    return dayOrder[day] ?? 0;
  }
}

class Day {
  String day;
  bool? isExpanded;

  Day({required this.day, this.isExpanded = true});
}
