import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/meal_plans/cubits/create_shopping_list_cubit.dart';
import 'package:menumaster_manager/application/meal_plans/shopping_list_bloc/shopping_list_bloc.dart';
import 'package:widgets_book/widgets_book.dart';

class ShoppingListIngredients extends StatelessWidget {
  const ShoppingListIngredients({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateShoppingListCubit, bool>(
      builder: (createShoppingContext, isShoppingListEditable) {
        return BlocBuilder<ShoppingListBloc, ShoppingListState>(
          builder: (context, shoppingState) {
            return (shoppingState is ShoppingListErrorState)
                ? StandardText.body2(
                    createShoppingContext,
                    shoppingState.message,
                  )
                : (shoppingState is ShoppingListLoadedState)
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        primary: false,
                        shrinkWrap: true,
                        itemCount: shoppingState.ingredients.length,
                        itemBuilder: (shoppingContext, index) {
                          Ingredient? ingredient =
                              shoppingState.ingredients.toList()[index];
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
                                      shoppingContext,
                                      (ingredient.name ?? 'N/A').toTitleCase(),
                                      // 'Butter',
                                      fontSize: 14.sp,
                                      letterSpacing: .80,
                                      color: AppColors.textBlack80,
                                      // ingredient.name ?? '',
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: !isShoppingListEditable ? 6 : 1,
                                  fit: FlexFit.tight,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 80),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (!isShoppingListEditable)
                                          InkWell(
                                            onTap: () {
                                              context
                                                  .read<ShoppingListBloc>()
                                                  .add(
                                                    SubtractQuantityShoppingListEvent(
                                                      ingredient: ingredient,
                                                    ),
                                                  );
                                            },
                                            child: const Icon(
                                              Icons.remove,
                                              size: 16,
                                              color: AppColors.accent,
                                            ),
                                          ),
                                        StandardText.subtitle3(
                                          context,
                                          ingredient.quantity == null
                                              ? ' ${(ingredient.quantity ?? '  0')}${ingredient.unit ?? '  '} '
                                              : ' ${removeZero(ingredient.quantity ?? '')}${ingredient.unit ?? '  '} ',
                                          fontSize: 14.sp,
                                          letterSpacing: .80,
                                          maxLines: 2,
                                          color: AppColors.textBlack80,
                                          // '${ingredient.quantity ?? ''} ${ingredient.unit}',
                                        ),
                                        if (!isShoppingListEditable)
                                          InkWell(
                                            onTap: () {
                                              context
                                                  .read<ShoppingListBloc>()
                                                  .add(
                                                    AddQuantityShoppingListEvent(
                                                      ingredient: ingredient,
                                                    ),
                                                  );
                                            },
                                            child: const Icon(
                                              Icons.add,
                                              size: 16,
                                              color: AppColors.accent,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Flexible(
                                //   flex: 2,
                                //   fit: FlexFit.tight,
                                //   child:  StandardText.subtitle3(
                                //         context,
                                //         // '\$7',
                                //         ingredient.price == null
                                //         || ingredient.price==0
                                //             ? '-'
                                //             : '\$${removeZero(ingredient.price!.toStringAsFixed(2))}',
                                //         fontSize: 14.sp,
                                //         letterSpacing: .80,
                                //         color: AppColors.textBlack80,
                                //       ),
                                // ),
                                if (!isShoppingListEditable)
                                  Flexible(
                                    flex: 2,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          context.read<ShoppingListBloc>().add(
                                                RemoveIngredient(
                                                  ingredient: ingredient,
                                                ),
                                              );
                                        },
                                        child: Assets.icons.closeAccent.svg(),
                                      ),
                                    ),
                                  )
                              ],
                            ),
                          );
                        },
                      )
                    : const SizedBox.shrink();
          },
        );
      },
    );
  }
}
