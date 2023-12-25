import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/meal_plans/shopping_list_bloc/shopping_list_bloc.dart';
import 'package:widgets_book/widgets_book.dart';

class ShoppingListEstimateCosting extends StatelessWidget {
  const ShoppingListEstimateCosting({
    super.key,
    this.onTapViewNutrition,
  });

  final VoidCallback? onTapViewNutrition;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingListBloc, ShoppingListState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: onTapViewNutrition,
              child: StandardText.subtitle2(
                context,
                'Estimate costing'.toUpperCase(),
                color: AppColors.accent,
                fontSize: 18.sp,
                fontWeight: AppFontWeight.medium,
              ),
            ),
            StandardText.subtitle2(
              context,
              state is ShoppingListLoadedState
                  ? '\$${removeZero(state.totalPrice?.toStringAsFixed(2) ?? '0.00')}'
                  : '\$0',
              color: AppColors.accent,
              fontSize: 15.sp,
              fontWeight: AppFontWeight.extraBold,
            ),
          ],
        );
      },
    );
  }
}
