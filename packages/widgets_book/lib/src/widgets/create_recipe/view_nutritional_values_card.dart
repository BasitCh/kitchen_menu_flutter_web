import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class ViewNutritionalValuesCard extends StatelessWidget {
  const ViewNutritionalValuesCard({
    super.key,
    this.onTapViewNutrition,
    this.isManager = false,
  });

  final VoidCallback? onTapViewNutrition;
  final bool? isManager;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onTapViewNutrition,
          child: Row(
            children: [
              const Icon(
                Icons.remove_red_eye,
                size: 22,
                color: AppColors.textBlack60,
              ),
              if (isManager!) 0.horizontalGap else 8.horizontalSpace,
              StandardText.subtitle2(
                context,
                AppLocalizations.of(context)!
                    .create_recipe_view_nutritional_values,
                decoration: TextDecoration.underline,
                color: AppColors.textBlack60,
              ),
            ],
          ),
        ),
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     // StandardText.subtitle2(
        //     //   context,
        //     //   AppLocalizations.of(context)!.create_recipe_estimated_cost,
        //     //   fontSize: 11.sp,
        //     //   fontWeight: AppFontWeight.medium,
        //     //   color: AppColors.accent,
        //     // ),
        //     BlocBuilder<CreateIngredientsCubit, CreateIngredientsCubitState>(
        //       builder: (context, state) {
        //         return StandardText.subtitle2(
        //           context,
        //           state.totalAmount != null
        //               ? '\$${state.totalAmount!.toStringAsFixed(1)}'
        //               : r'$0',
        //           color: AppColors.accent,
        //           fontSize: 15.sp,
        //           fontWeight: AppFontWeight.extraBold,
        //         );
        //       },
        //     ),
        //   ],
        // )
      ],
    );
  }
}
