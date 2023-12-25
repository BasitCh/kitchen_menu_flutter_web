import 'package:flutter/material.dart';
import 'package:menumaster_manager/domain/meal_plans/recipe_image.dart';
import 'package:widgets_book/widgets_book.dart';

class RecipeAvatarImages extends StatelessWidget {
  const RecipeAvatarImages({
    super.key,
    required this.visible,
    required this.recipeImages,
    this.indexSelected,
  });
  final ValueNotifier<int>? indexSelected;

  final bool visible;
  final List<RecipeImage>? recipeImages;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: SizedBox(
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recipeImages != null ? recipeImages!.length - 1 : 0,
          itemBuilder: (context, index) {
            RecipeImage? recipeImage = recipeImages?[index];
            return GestureDetector(
              onTap: indexSelected?.value!=null?(){
                indexSelected!.value=index;
              }:null,
              child: Padding(
                padding: index == 0
                    ? const EdgeInsets.only(
                  left: 20,
                  right: 16.0,
                )
                    : const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  backgroundColor: AppColors.accent,
                  radius: 32,
                  child: CircleAvatar(
                    backgroundColor: AppColors.accent,
                    radius: 31,
                    backgroundImage: recipeImage?.url != null
                        ? NetworkImage(recipeImage!.url!)
                        : null,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}