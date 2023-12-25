import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class RecipesFilterPage extends StatelessWidget {
  const RecipesFilterPage({
    required this.recipesFilterCubit,
    super.key,
  });

  final RecipesFilterCubit recipesFilterCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecipesFilterCubit, List<RecipesFilterState>>(
      bloc: recipesFilterCubit,
      builder: (context, state) {
        return Center(
          child: Container(
            width: kIsWeb?MediaQuery.of(context).size.width / 2:context.width,
            height: kIsWeb?MediaQuery.of(context).size.height / 1.1:context.height - 120,
            //color: AppColors.white,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            //padding: const EdgeInsets.symmetric(horizontal: 23),
            child: kIsWeb?Scaffold(
              backgroundColor: AppColors.transparent,
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Stack(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20,top: 20),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          //hoverColor: AppColors.transparent,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: AppColors.black,
                            )),
                      ),
                    ),

                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        65.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StandardText.headline6(
                            context,
                            'SELECT FILTERS',
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                          MaterialButton(
                            onPressed: () {
                              context.read<RecipesFilterCubit>().reset();

                            },
                            child: StandardText.subtitle3(
                              context,
                              'RESET FILTERS',
                              color: AppColors.accent,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
                      5.verticalSpace,
                      StandardText.subtitle3(
                        context,
                        '''Select one or more filters from the following\nlist that are applicable.''',
                        color: AppColors.textBlack,
                        align: TextAlign.left,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                      57.verticalGap,
                      if(kIsWeb)Wrap(
                        children: [
                          if (state.isNotEmpty)
                            ...state
                                .map(
                                  (e) => RecipeFilterExpandableTile(
                                title: e.title.toUpperCase(),
                                filters: e.filters,
                              ),
                            )
                                .toList(),
                        ],
                      ) else Column(
                        children: [
                          if (state.isNotEmpty)
                            ...state
                                .map(
                                  (e) => RecipeFilterExpandableTile(
                                title: e.title.toUpperCase(),
                                filters: e.filters,
                              ),
                            )
                                .toList(),
                        ],
                      ),
                      50.verticalGap,
                      Center(
                        child: SizedBox(
                          width: context.width / 5,
                          child: AppButton.darkRed(
                            onPressed: () {
                              List<FilterState> filtersState = [];
                              Navigator.pop(context);
                              context
                                  .read<RecipesFilterCubit>()
                                  .updateFilters(state);
                              context
                                  .read<RecipesFilterCubit>()
                                  .state
                                  .forEach((allRecipeFilter) {
                                allRecipeFilter.filters.forEach((filter) {
                                  if (filter.value) {
                                    filtersState.add(filter);
                                  }
                                });
                              });
                              context
                                  .read<RecipesAppliedFiltersCubit>()
                                  .updateAppliedFilters(filtersState);
                            },
                            child: StandardText.buttonLarge(
                              AppLocalizations.of(context)!
                                  .all_recipes_apply_filters,
                            ),
                          ),
                        ),
                      ),
                      50.verticalSpace,
                    ],),
                  ),



                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     StandardText.headline5(
                    //       context,
                    //       AppLocalizations.of(context)!
                    //           .all_recipes_select_filters
                    //           .toUpperCase(),
                    //       fontSize: 18,
                    //       fontWeight: AppFontWeight.bold,
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         context.read<RecipesFilterCubit>().reset();
                    //       },
                    //       child: StandardText.subtitle2(
                    //         context,
                    //         AppLocalizations.of(context)!
                    //             .all_recipes_reset_filters,
                    //         color: AppColors.accent,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // 14.verticalSpace,
                    // Container(
                    //   padding: const EdgeInsets.only(right: 50, bottom: 10),
                    //   child: StandardText.subtitle2(
                    //     context,
                    //     AppLocalizations.of(context)!
                    //         .all_recipes_select_one_or_more,
                    //     letterSpacing: -0.28,
                    //     height: 1.5,
                    //   ),
                    // ),

                  ],
                ),
              ),
            ):
            Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      66.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StandardText.headline5(
                            context,
                            AppLocalizations.of(context)!
                                .all_recipes_select_filters
                                .toUpperCase(),
                            fontSize: 18,
                            fontWeight: AppFontWeight.bold,
                          ),
                          InkWell(
                            onTap: () {
                              context.read<RecipesFilterCubit>().reset();
                            },
                            child: StandardText.subtitle2(
                              context,
                              AppLocalizations.of(context)!
                                  .all_recipes_reset_filters,
                              color: AppColors.accent,
                            ),
                          ),
                        ],
                      ),
                      14.verticalSpace,
                      Container(
                        padding: const EdgeInsets.only(right: 50, bottom: 10),
                        child: StandardText.subtitle2(
                          context,
                          AppLocalizations.of(context)!
                              .all_recipes_select_one_or_more,
                          letterSpacing: -0.28,
                          height: 1.5,
                        ),
                      ),
                      if(kIsWeb)Wrap(
                        children: [
                          if (state.isNotEmpty)
                            ...state
                                .map(
                                  (e) => RecipeFilterExpandableTile(
                                title: e.title.toUpperCase(),
                                filters: e.filters,
                              ),
                            )
                                .toList(),
                        ],
                      ) else Column(
                        children: [
                          if (state.isNotEmpty)
                            ...state
                                .map(
                                  (e) => RecipeFilterExpandableTile(
                                    title: e.title.toUpperCase(),
                                    filters: e.filters,
                                  ),
                                )
                                .toList(),
                        ],
                      ),
                      Center(
                        child: SizedBox(
                          width: context.width / 5,
                          child: AppButton.darkRed(
                            onPressed: () {
                              List<FilterState> filtersState = [];
                              Navigator.pop(context);
                              context
                                  .read<RecipesFilterCubit>()
                                  .updateFilters(state);
                              context
                                  .read<RecipesFilterCubit>()
                                  .state
                                  .forEach((allRecipeFilter) {
                                allRecipeFilter.filters.forEach((filter) {
                                  if (filter.value) {
                                    filtersState.add(filter);
                                  }
                                });
                              });
                              context
                                  .read<RecipesAppliedFiltersCubit>()
                                  .updateAppliedFilters(filtersState);
                            },
                            child: StandardText.buttonLarge(
                              AppLocalizations.of(context)!
                                  .all_recipes_apply_filters,
                            ),
                          ),
                        ),
                      ),
                      50.verticalSpace,
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: EdgeInsets.only(top: 15.h),
                      width: 44,
                      height: 4.16,
                      decoration: ShapeDecoration(
                        color: AppColors.rose,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
