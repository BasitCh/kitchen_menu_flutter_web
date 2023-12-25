import 'package:flutter/material.dart';
import 'package:widgets_book/src/widgets/create_recipe/ingredients_table_content.dart';
import 'package:widgets_book/src/widgets/create_recipe/ingredients_table_header.dart';
import 'package:widgets_book/src/widgets/create_recipe/view_nutritional_values_card.dart';
import 'package:widgets_book/widgets_book.dart';

class IngredientsTable extends StatelessWidget {
  const IngredientsTable({
    required this.nameTextEditingController,
    required this.quantityTextEditingController,
    required this.priceTextEditingController,
    required this.createIngredientsCubit,
    this.quantityWidget,
    this.onAddIngredient,
    this.onTapViewNutrition,
    this.isReviewRecipe = false,
    this.ingredientSuggestionWidget,
    this.isLoadingInfo,
    this.onChangedRecipeName,
    this.isManager = false,
    // this.quantityAppModalWidget,
    super.key,
  });

  final TextEditingController? nameTextEditingController;
  final TextEditingController? quantityTextEditingController;
  final TextEditingController? priceTextEditingController;
  final VoidCallback? onTapViewNutrition;
  final bool isReviewRecipe;
  final CreateIngredientsCubit createIngredientsCubit;
  final Widget? ingredientSuggestionWidget;
  final Future<Ingredient> Function(Ingredient)? onAddIngredient;
  final bool? isLoadingInfo;
  final void Function(String)? onChangedRecipeName;
  final Widget? quantityWidget;
  final bool? isManager;
  // final Widget? quantityAppModalWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _IngredientTableWidget(
          createIngredientsCubit: createIngredientsCubit,
          isReviewRecipe: isReviewRecipe,
          isManager: isManager,
        ),
        if (!isReviewRecipe) 25.verticalSpace,
        if (!isReviewRecipe)
          IngredientsTableInputContent(
            nameTextEditingController: nameTextEditingController!,
            quantityTextEditingController: quantityTextEditingController!,
            priceTextEditingController: priceTextEditingController!,
            onAddIngredient: onAddIngredient,
            isLoadingInfo: isLoadingInfo,
            onChangedRecipeName: onChangedRecipeName,
            // quantityAppModalWidget: quantityAppModalWidget,
            quantityWidget: quantityWidget ?? Container(),
          ),
        if (ingredientSuggestionWidget != null) ingredientSuggestionWidget!,
        25.verticalSpace,
        if (isManager!)
          const SizedBox.shrink()
        else
          const AppDivider(
            color: AppColors.rose,
          ),
        10.verticalSpace,
        ViewNutritionalValuesCard(
          onTapViewNutrition: onTapViewNutrition,
        ),
        10.verticalSpace,
        if (isManager!)
          const SizedBox.shrink()
        else
          const AppDivider(
            color: AppColors.rose,
          ),
        25.verticalSpace,
      ],
    );
  }
}

class _IngredientTableWidget extends StatefulWidget {
  const _IngredientTableWidget({
    required this.createIngredientsCubit,
    required this.isReviewRecipe,
    this.isManager = false,
  });

  final CreateIngredientsCubit createIngredientsCubit;
  final bool isReviewRecipe;
  final bool? isManager;

  @override
  State<_IngredientTableWidget> createState() => _IngredientTableWidgetState();
}

class _IngredientTableWidgetState extends State<_IngredientTableWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateIngredientsCubit, CreateIngredientsCubitState>(
      bloc: widget.createIngredientsCubit,
      builder: (ctx, ingredientsState) {
        return Card(
          elevation: 3,
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
              padding: EdgeInsets.zero,
              primary: false,
              shrinkWrap: true,
              children: [
                IngredientsTableHeader(
                  isReviewRecipe: widget.isReviewRecipe,
                  isManager: widget.isManager,
                ),
                const AppDivider(),
                if (ingredientsState.ingredients.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: StandardText.subtitle3(
                      context,
                      AppLocalizations.of(context)!
                          .create_recipe_no_ingredients_added_yet,
                      fontWeight: AppFontWeight.bold,
                    ),
                  )
                else
                  IngredientsTableContent(
                    ingredients: ingredientsState.ingredients,
                    isReviewRecipe: widget.isReviewRecipe,
                    isManager: widget.isManager
                  ),
                10.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
