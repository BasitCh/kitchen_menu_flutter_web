// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:widgets_book/widgets_book.dart';

class NutritionInformationSheet extends StatefulWidget {
   NutritionInformationSheet({this.isManager = false, Key? key}) : super(key: key);

  bool? isManager;

  @override
  State<NutritionInformationSheet> createState() =>
      _NutritionInformationSheetState();
}

class _NutritionInformationSheetState extends State<NutritionInformationSheet> {
  Map<String, String> filtersName = {};

  @override
  void initState() {
    filtersName.putIfAbsent('calories', () => 'calories');
    filtersName.putIfAbsent('iron', () => 'iron');
    filtersName.putIfAbsent('protein', () => 'protein');
    filtersName.putIfAbsent('carbohydrates', () => 'carbohydrates');
    filtersName.putIfAbsent('fat', () => 'fat');
    filtersName.putIfAbsent('fiber', () => 'fiber');
    filtersName.putIfAbsent('calcium', () => 'calcium');
    filtersName.putIfAbsent('sugar', () => 'sugar');
    filtersName.putIfAbsent('sodium', () => 'sodium');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateIngredientsCubit, CreateIngredientsCubitState>(
      builder: (context, createIngredientState) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            40.verticalSpace,
            StandardText.headline6(
              context,
              AppLocalizations.of(context)!.create_recipe_nutrition_information,
              fontWeight: AppFontWeight.bold,
            ),
            20.verticalSpace,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Card(
                elevation: 6,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: 20.h, bottom: 10.h, left: 14.h, right: 14.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StandardText.subtitle3(
                              context,
                              AppLocalizations.of(context)!
                                  .create_recipe_nutrition_per_child,
                              fontWeight: AppFontWeight.semiBold,
                            ),
                            StandardText.subtitle3(
                              context,
                              AppLocalizations.of(context)!
                                  .create_recipe_daily_value,
                              fontWeight: AppFontWeight.semiBold,
                            ),
                          ],
                        ),
                      ),
                      const AppDivider(),
                      ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount:
                              createIngredientState.nutrients?.keys.length ?? 0,
                          itemBuilder: (context, index) {
                            IngredientInformationNutritionNutrients? nutrient =
                                createIngredientState.nutrients?.values
                                    .toList()[index];
                            if (filtersName.containsValue(
                                nutrient!.name!.trim().toLowerCase())) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 20.h,
                                ),
                                decoration: index.isOdd
                                    ? const BoxDecoration(
                                        color: AppColors.lightGrey,
                                      )
                                    : null,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    StandardText.subtitle3(
                                      context,
                                      nutrient.name ?? '',
                                    ),
                                    StandardText.subtitle3(
                                      context,
                                      '${nutrient.percentOfDailyNeeds?.toStringAsFixed(1) ?? 0}${nutrient.unit ?? 0}',
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                      10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
            if (!widget.isManager!) ... [
              30.verticalSpace,
            AppButton.darkRed(
              child: StandardText.buttonLarge(
                AppLocalizations.of(context)!.create_recipe_got_it,
              ),
              onPressed: () {
                getIt<NavigationService>().navigateBack(context: context);
              },
            ),
            ],
            20.verticalSpace,
          ],
        );
      },
    );
  }
}
