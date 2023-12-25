import 'package:flutter/material.dart';
import 'package:menumaster_manager/domain/meal_plans/linked_recipe.dart';
import 'package:widgets_book/widgets_book.dart';

class LinkedRecipes extends StatelessWidget {
  const LinkedRecipes({
    super.key,
    required this.linkedRecipe,
  });

  final LinkedRecipe linkedRecipe;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StandardText.subtitle2(
          context,
          'LINKED RECIPES',
          fontSize: 18.sp,
          fontWeight: AppFontWeight.bold,
        ),
        10.verticalSpace,
        InkWell(
          onTap: () {
            // getIt<NavigationService>().pushNamed(
            //   context: context,
            //   uri: NavigationService.linkedRecipeDetailRouteUri,
            //   data: linkedRecipe.id??'',
            // );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.grey500,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.accent,
                  backgroundImage: linkedRecipe.imageUrl != null
                      ? NetworkImage(linkedRecipe.imageUrl!)
                      : null,
                ),
                10.horizontalSpace,
                StandardText.subtitle2(
                  context,
                  linkedRecipe.name ?? '',
                  fontSize: 14.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
