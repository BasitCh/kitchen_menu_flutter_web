import 'package:flutter/material.dart';
import 'package:menumaster_manager/domain/meal_plans/recipe.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/presentation/meal_plans/widgets/recipe_details_widgets/recipes_dialog.dart';
import 'package:widgets_book/widgets_book.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.categoryName,
    required this.day,
    required this.recipes,
    required this.date,
    required this.startDate,
    required this.endDate,
    this.numberOfChildren,
  });

  final String? categoryName;
  final List<Recipe>? recipes;
  final String? day;
  final DateTime? date;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? numberOfChildren;

  @override
  Widget build(BuildContext context) {
    return recipes != null && recipes!.isEmpty
        ? Container()
        : InkWell(
            onTap: recipes?.first.id != null
                ? () {
                    if (recipes!.length > 1) {
                      showRecipesDialog(
                          recipes: recipes ?? [], context: context);
                    } else {
                      getIt<NavigationService>().navigateToNamed(
                        context: context,
                        uri: NavigationService.recipeDetailsUri,
                        data: recipes?.first.id ?? '',
                      );
                    }
                  }
                : null,
            child: Card(
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: recipes?.first.images?.first.url !=
                                  null
                              ? NetworkImage(recipes!.first.images!.first.url!)
                              : null,
                          backgroundColor: AppColors.accent,
                        ),
                        if (recipes!.length > 1)
                          Positioned(
                            top: 12,
                            right: -10,
                            child: Container(
                              width: 32.h,
                              height: 32.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  border: Border.all(
                                    color: AppColors.white,
                                    width: 2,
                                  ),
                                  image:
                                      recipes?.first.images?.first.url != null
                                          ? DecorationImage(
                                              image: NetworkImage(recipes!
                                                  .first.images!.first.url!),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(
                                                AppColors.black.withOpacity(.6),
                                                BlendMode.darken,
                                              ),
                                              onError: (_, st) {
                                                const SizedBox();
                                              })
                                          : null),
                              child: StandardText.subtitle3(
                                context,
                                '+${recipes!.length - 1}',
                                fontSize: 11.sp,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    5.verticalSpace,
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: StandardText.subtitle3(
                          context,
                          recipes?.first.name ?? '',
                          fontSize: 14.sp,
                          color: AppColors.textBlack80,
                          align: TextAlign.center,
                          fontWeight: AppFontWeight.semiBold,
                        ),
                      ),
                    ),
                    5.verticalSpace,
                    StandardText.subtitle3(
                      context,
                      (categoryName ?? '').toUpperCase(),
                      fontSize: 16.sp,
                      color: AppColors.accent,
                      fontWeight: AppFontWeight.semiBold,
                    ),
                    5.verticalSpace,
                  ],
                ),
              ),
            ),
          );
  }
}
