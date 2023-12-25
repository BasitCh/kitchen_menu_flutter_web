import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class IngredientsTableContent extends StatelessWidget {
  const IngredientsTableContent({
    required this.ingredients,
    required this.isReviewRecipe,
    this.isManager = false,
    super.key,
  });

  final List<Ingredient> ingredients;
  final bool isReviewRecipe;
  final bool? isManager;

  @override
  Widget build(BuildContext context) {
    // var createIngredientsCubit = context.read<CreateIngredientsCubit>();
    return ListView.builder(
      padding: EdgeInsets.zero,
      primary: false,
      shrinkWrap: true,
      itemCount: ingredients.length,
      itemBuilder: (context, index) {
        final ingredient = ingredients[index];
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
            children: [
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: StandardText.subtitle3(
                    context,
                    ingredient.name ?? '',
                    fontSize: isManager! ? 14.sp : 12.sp,
                    fontWeight:FontWeight.w500 ,

                  ),
                ),
              ),
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: StandardText.subtitle3(
                  context,
                  '${ingredient.quantity ?? ''} ${ingredient.unit}',
                  fontSize: isManager! ? 14.sp : 12.sp,
                  fontWeight:FontWeight.w500 ,

                ),
              ),
              // Flexible(
              //   flex: 2,
              //   fit: FlexFit.tight,
              //   child: StandardText.subtitle3(
              //     context,
              //     ingredient.price == null || ingredient.price == 0
              //         ? '-'
              //         : '\$${ingredient.price!.toStringAsFixed(1)}',
              //   ),
              // ),
              Visibility(
                visible: !isReviewRecipe,
                child: Flexible(
                  fit: FlexFit.tight,
                  child: InkWell(
                    onTap: () {
                      context
                          .read<CreateIngredientsCubit>()
                          .removeIngredient(ingredient);
                    },
                    child: const Icon(
                      Icons.close,
                      size: 16,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
