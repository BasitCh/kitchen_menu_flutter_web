// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/meal_plans/cubits/meal_plan_start_end_dates_cubit.dart';
import 'package:menumaster_manager/application/meal_plans/meal_plan_bloc/meal_plan_bloc.dart';
import 'package:widgets_book/widgets_book.dart';

class MealDateRange extends StatelessWidget {
  const MealDateRange({super.key, required this.userId,});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MealPlanStartEndDatesCubit, MealPlanStartEndDatesState>(
      builder: (context, mealPlanDates) {
        return Row(
          children: [
            InkWell(
              onTap: () {
                context.read<MealPlanStartEndDatesCubit>().previousWeek();
                context.read<MealPlanBloc>().add(
                      GetMealPlans(
                        userId: userId,
                        startDate: context
                                .read<MealPlanStartEndDatesCubit>()
                                .state
                                .startDate ??
                            DateTime.now(),
                        endDate: context
                                .read<MealPlanStartEndDatesCubit>()
                                .state
                                .endDate ??
                            DateTime.now(),
                      ),
                    );
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 17,
              ),
            ),
            InkWell(
              onTap: () async {
                final now = DateTime.now();
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: now,
                    firstDate: DateTime(now.year - 1, now.month, now.day),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  context
                      .read<MealPlanStartEndDatesCubit>()
                      .update(dateTime: pickedDate);
                  context.read<MealPlanBloc>().add(
                        GetMealPlans(
                          userId: userId,
                          startDate: context
                                  .read<MealPlanStartEndDatesCubit>()
                                  .state
                                  .startDate ??
                              DateTime.now(),
                          endDate: context
                                  .read<MealPlanStartEndDatesCubit>()
                                  .state
                                  .endDate ??
                              DateTime.now(),
                        ),
                      );
                } else {}
              },
              child: StandardText.subtitle2(
                context,
                ' ${mealPlanDates.startDate?.toMMMdd() ?? ''} - ${mealPlanDates.endDate?.toMMMdd() ?? ''}  ',
                fontSize: 14.sp,
                fontWeight: AppFontWeight.medium,
              ),
            ),
            InkWell(
              onTap: () {
                context.read<MealPlanStartEndDatesCubit>().nextWeek();
                context.read<MealPlanBloc>().add(
                      GetMealPlans(
                        userId: userId,
                        startDate: context
                                .read<MealPlanStartEndDatesCubit>()
                                .state
                                .startDate ??
                            DateTime.now(),
                        endDate: context
                                .read<MealPlanStartEndDatesCubit>()
                                .state
                                .endDate ??
                            DateTime.now(),
                      ),
                    );
              },
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 17,
              ),
            ),
          ],
        );
      },
    );
  }
}
