import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/meal_plans/meal_plan_bloc/meal_plan_bloc.dart';
import 'package:menumaster_manager/domain/meal_plans/meal_plan.dart';
import 'package:menumaster_manager/presentation/meal_plans/widgets/meal_item.dart';
import 'package:widgets_book/widgets_book.dart';

class MealList extends StatefulWidget {
  const MealList({super.key, required this.daywiseMealPlan});

  final Map<Day, List<MealPlan>> daywiseMealPlan;

  @override
  State<MealList> createState() => _MealListState();
}

class _MealListState extends State<MealList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.daywiseMealPlan.keys.length,
        itemBuilder: ((context, pIndex) {
          final days = widget.daywiseMealPlan.keys.toList();
          final mealPlans = widget.daywiseMealPlan[days[pIndex]];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    days[pIndex].isExpanded = !days[pIndex].isExpanded!;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StandardText.headline1(
                        context,
                        days[pIndex].day.toString(),
                        fontSize: 22,
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                        align: TextAlign.start,
                        fontFamily: Assets.fonts.poppinsBold,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColors.black,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: days[pIndex].isExpanded!,
                child: AnimatedOpacity(
                  duration: const Duration(seconds: 20),
                  opacity: days[pIndex].isExpanded! ? 1 : 0,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              decoration: BoxDecoration(
                                  color: AppColors.greyLight,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      width: 1, color: AppColors.greyBg)),
                              child: StandardText.headline1(
                                context,
                                'Number of children: ${mealPlans?[0].numberOfChildren ?? 0}',
                                fontSize: 16,
                                color: AppColors.black,
                                fontWeight: FontWeight.w500,
                                align: TextAlign.start,
                                fontFamily: Assets.fonts.poppinsRegular,
                              ),
                            ),
                          ),
                          const Flexible(flex: 4, child: SizedBox())
                        ],
                      ),
                      SizedBox(
                        height: 230,
                        child: ListView.builder(
                          itemCount: mealPlans?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final plan = mealPlans?[index];
                            return MealItem(
                              categoryName: plan?.category,
                              day: plan?.day ?? '',
                              recipes: plan?.recipes,
                              date: plan?.mealDate,
                              startDate: plan?.startDate,
                              endDate: plan?.endDate,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              20.verticalGap,
            ],
          );
        }));
  }
}
