import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/meal_plans/cubits/create_shopping_list_cubit.dart';
import 'package:widgets_book/widgets_book.dart';

class ShoppingListIngredientHeader extends StatelessWidget {
  const ShoppingListIngredientHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateShoppingListCubit, bool>(
      builder: (createShoppingContext, isShoppingListEditable) {
        return Container(
          padding:
              EdgeInsets.only(top: 20.h, bottom: 10.h, left: 20.h, right: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 3,
                child: StandardText.subtitle3(
                  context,
                  AppLocalizations.of(context)!
                      .create_recipe_ingredients
                      .toLowerCase()
                      .toTitleCase(),
                  fontWeight: AppFontWeight.semiBold,
                  fontSize: 15.sp,
                  letterSpacing: .80,
                  color: AppColors.textBlack80,
                ),
              ),
              const Spacer(),
              Flexible(
                child: Container(
                  transform: Matrix4.translationValues(
                      !isShoppingListEditable ? 20 : 0, 0, 0),
                  padding: const EdgeInsets.only(right: 50),
                  child: StandardText.subtitle3(
                    context,
                    AppLocalizations.of(context)!.create_recipe_qty,
                    fontWeight: AppFontWeight.semiBold,
                    align: TextAlign.left,
                    fontSize: 15.sp,
                    letterSpacing: .80,
                    color: AppColors.textBlack80,
                  ),
                ),
              ),
              if (!isShoppingListEditable) Flexible(flex: 3, child: Container())
              // Flexible(
              //   flex: 2,
              //   fit: FlexFit.tight,
              //   child: StandardText.subtitle3(
              //     context,
              //     AppLocalizations.of(context)!.create_recipe_nzd,
              //     fontWeight: AppFontWeight.semiBold,
              //     fontSize: 15.sp,
              //     letterSpacing: .80,
              //     color: AppColors.textBlack80,
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
