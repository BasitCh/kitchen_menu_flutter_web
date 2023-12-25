import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/recipe_detail/recipe_detail_bloc.dart';
import 'package:menumaster_manager/presentation/meal_plans/widgets/recipe_details_widgets/allergies_card.dart';
import 'package:menumaster_manager/presentation/meal_plans/widgets/recipe_details_widgets/linked_recipes.dart';
import 'package:menumaster_manager/presentation/meal_plans/widgets/recipe_details_widgets/nutritions_dialog.dart';
import 'package:menumaster_manager/presentation/meal_plans/widgets/recipe_details_widgets/recipe_detail_app_bar.dart';
import 'package:menumaster_manager/presentation/meal_plans/widgets/recipe_details_widgets/recipe_images.dart';
import 'package:menumaster_manager/presentation/meal_plans/widgets/recipe_details_widgets/review_recipe_prep_steps.dart';
import 'package:menumaster_manager/presentation/widgets/app_bar.dart';
import 'package:widgets_book/widgets_book.dart';

class RecipeDetailPage extends StatefulWidget {
  const RecipeDetailPage({
    Key? key,
     this.recipeId,
  }) : super(key: key);

  final String? recipeId;

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  ValueNotifier<int> index = ValueNotifier(0);
  @override
  void dispose() {
    index.dispose();
    super.dispose();
  }

  @override
  void initState() {
    this.context.read<RecipeDetailBloc>().add(
          FetchRecipeDetail(recipeId: widget.recipeId ?? ''),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RecipeDetailBloc, RecipeDetailState>(
      listener: (context, state) {
        if (state is RecipeDetailLoaded) {
          context.read<CreatePrepStepCubits>().reset();
          context.read<CreateIngredientsCubit>().initialize(
                state.recipe.ingredients ?? [],
              );
          context.read<CreatePrepStepCubits>().initialize(
                state.recipe.preparationSteps ?? [],
              );
        }
      },
      child: BaseScaffold(
        appBar: const ManagerBar(),
        appBarHeight: 80,
        body: BlocBuilder<RecipeDetailBloc, RecipeDetailState>(
          builder: (context, state) {
            return (state is RecipeDetailLoading)
                ? const AppButtonLoading()
                : (state is RecipeDetailError)
                    ? StandardText.headline5(context, state.message)
                    : (state is RecipeDetailLoaded)
                        ? CustomScrollView(
                            slivers: [
                              ValueListenableBuilder<int>(
                                  valueListenable: index,
                                  builder: (context, value, child) {
                                    return RecipeDetailAppBar(
                                      title: state.recipe.name ?? '',
                                      description:
                                          state.recipe.description ?? '',
                                      imageUrl: state.recipe.images != null &&
                                              state.recipe.images!.isNotEmpty
                                          ? state.recipe.images![value].url ??
                                              ''
                                          : '',
                                    );
                                  }),
                              SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    25.verticalSpace,
                                    RecipeAvatarImages(
                                      visible: state.recipe.images != null &&
                                          state.recipe.images!.length - 1 > 1,
                                      recipeImages: state.recipe.images,
                                      indexSelected: index,
                                    ),
                                    25.verticalSpace,
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          StandardText.subtitle2(
                                            context,
                                            state.recipe.description ?? '',
                                            color: AppColors.textBlack60,
                                            fontSize: 14.sp,
                                          ),
                                          28.verticalSpace,
                                          StandardText.headline5(
                                            context,
                                            AppLocalizations.of(context)!
                                                .create_recipe_category_filters,
                                            fontSize: 18.sp,
                                            fontWeight: AppFontWeight.bold,
                                          ),
                                          10.verticalSpace,
                                          AppStandardTextField.outlined(
                                            controller: TextEditingController(
                                              text:
                                                  '   ${state.recipe.foodCategory?.map((foodCategory) => foodCategory.categoryName).join(', ') ?? ''}',
                                            ),
                                            validator: (val) => emptyValidation(
                                                val,
                                                AppLocalizations.of(context)!
                                                    .create_recipe_empty_name_validation),
                                            hintText: AppLocalizations.of(
                                                    context)!
                                                .create_recipe_give_your_recipe_a_name,
                                            borderRadius: 10,
                                            isEnabled: false,
                                            readOnly: true,
                                            fillColor: AppColors.grey500,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 20,
                                                    horizontal: 20),
                                          ),
                                          if (state.recipe.filters != null &&
                                              state.recipe.filters!
                                                  .isNotEmpty) ...[
                                            30.verticalSpace,
                                            StandardText.headline5(
                                              context,
                                              AppLocalizations.of(context)!
                                                  .all_recipes_applied_filters,
                                              fontSize: 16.sp,
                                              fontWeight: AppFontWeight.medium,
                                            ),
                                            13.verticalSpace,
                                            Wrap(
                                              children: state.recipe.filters!
                                                  .map((filter) => Container(
                                                        margin: const EdgeInsets
                                                            .only(
                                                            right: 6,
                                                            bottom: 6),
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 14,
                                                          vertical: 10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .charcool,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                        ),
                                                        child: StandardText
                                                            .subtitle2(
                                                          context,
                                                          filter,
                                                          fontSize: 12.sp,
                                                          color:
                                                              AppColors.white,
                                                        ),
                                                      ))
                                                  .toList(),
                                            ),
                                          ],
                                          30.verticalSpace,
                                          StandardText.subtitle2(
                                            context,
                                            AppLocalizations.of(context)!
                                                .create_recipe_ingredients,
                                            fontSize: 18.sp,
                                            fontWeight: AppFontWeight.bold,
                                          ),
                                          Visibility(
                                            visible: state.recipe
                                                        .noOfRecipeChildren !=
                                                    null &&
                                                state.recipe
                                                        .noOfRecipeChildren !=
                                                    '',
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                13.verticalSpace,
                                                Container(
                                                  // padding: const EdgeInsets.only(left: 19,right: 19,top: 15,bottom: 15),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.sp)),
                                                      border: Border.all(
                                                          color:
                                                              AppColors.greybg),
                                                      color:
                                                          AppColors.greyLight),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Assets.icons.icBulbNew
                                                          .svg(),
                                                      12.horizontalGap,
                                                      Expanded(
                                                        child: Text.rich(
                                                          TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    'Number of Children: ',
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color(
                                                                      0xFF010F07),
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  letterSpacing:
                                                                      0.80,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    '${state.recipe.noOfRecipeChildren ?? ''}',
                                                                style:
                                                                    TextStyle(
                                                                  color: const Color(
                                                                      0xFF010F07),
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  letterSpacing:
                                                                      0.80,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          20.verticalSpace,
                                          IngredientsTable(
                                            nameTextEditingController: null,
                                            priceTextEditingController: null,
                                            quantityTextEditingController: null,
                                            isReviewRecipe: true,
                                            isManager: true,
                                            createIngredientsCubit: context
                                                .read<CreateIngredientsCubit>(),
                                            onTapViewNutrition: () {
                                              showNutritionsDialog(
                                                  context: context);
                                            },
                                          ),
                                          if (state.recipe.linkedRecipe !=
                                                  null &&
                                              state.recipe.linkedRecipe?.name !=
                                                  null &&
                                              state.recipe.linkedRecipe!.name!
                                                  .isNotEmpty) ...[
                                            // 30.verticalSpace,
                                            LinkedRecipes(
                                                linkedRecipe:
                                                    state.recipe.linkedRecipe!),
                                            20.verticalGap,
                                          ],
                                          if (state.recipe.companyId != null &&
                                              state.recipe.companyId!
                                                  .isNotEmpty) ...[
                                            AllergiesCard(
                                              // filters: state.recipe.filters,
                                              companyId: state.recipe.companyId,
                                              isCreateRecipe: false,
                                            ),
                                            25.verticalSpace,
                                          ],
                                          StandardText.headline5(
                                            context,
                                            'PREP & COOK TIME',
                                            fontSize: 18.sp,
                                            fontWeight: AppFontWeight.bold,
                                          ),
                                          10.verticalSpace,
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  margin: EdgeInsets.only(
                                                      right: 5.h),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20,
                                                            bottom: 20,
                                                            left: 20,
                                                            right: 80),
                                                    decoration: BoxDecoration(
                                                        color: AppColors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        StandardText.subtitle2(
                                                          context,
                                                          'Prep Time',
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              AppFontWeight
                                                                  .bold,
                                                        ),
                                                        10.verticalSpace,
                                                        StandardText.subtitle2(
                                                          context,
                                                          '${state.recipe.prepareTime?.split(':')[0]} hour,\n${state.recipe.prepareTime?.split(':')[1]} Minute',
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              AppFontWeight
                                                                  .regular,
                                                          align:
                                                              TextAlign.start,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  margin: EdgeInsets.only(
                                                      left: 5.h),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20,
                                                            bottom: 20,
                                                            left: 20,
                                                            right: 80),
                                                    decoration: BoxDecoration(
                                                        color: AppColors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        StandardText.subtitle2(
                                                          context,
                                                          'Cook Time',
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              AppFontWeight
                                                                  .bold,
                                                        ),
                                                        10.verticalSpace,
                                                        StandardText.subtitle2(
                                                          context,
                                                          '${state.recipe.cookTime?.split(':')[0]} hour,\n${state.recipe.cookTime?.split(':')[1]} Minute',
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              AppFontWeight
                                                                  .regular,
                                                          align:
                                                              TextAlign.start,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          25.verticalSpace,
                                          const ReviewRecipePrepSteps(),
                                          50.verticalSpace,
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
