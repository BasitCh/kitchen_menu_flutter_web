import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/get_children_bloc/get_children_bloc.dart';
import 'package:menumaster_manager/application/meal_plans/company_allergies_bloc/company_allergies_bloc.dart';
import 'package:widgets_book/widgets_book.dart';

class AllergiesCard extends StatefulWidget {
  const AllergiesCard({
    Key? key,
    this.filters,
    this.companyId,
    this.isCreateRecipe = true,
  }) : super(key: key);

  final List<String>? filters;
  final String? companyId;
  final bool isCreateRecipe;

  @override
  State<AllergiesCard> createState() => _AllergiesCardState();
}

class _AllergiesCardState extends State<AllergiesCard> {
  @override
  void initState() {
    if (widget.companyId != null) {
      this.context.read<CompanyAllergiesBloc>().add(
            GetCompanyAllergies(
              companyId: widget.companyId,
            ),
          );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyAllergiesBloc, CompanyAllergiesState>(
      builder: (context, allergiesState) {
        return (allergiesState is CompanyAllergiesLoading) ||
                (allergiesState is CompanyAllergiesEmpty)
            ? const SizedBox.shrink()
            : (allergiesState is CompanyAllergiesLoaded)
                ? Card(
                    margin: EdgeInsets.zero,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.white,
                      ),
                      padding: const EdgeInsets.only(
                        top: 28,
                        bottom: 28,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StandardText.headline5(
                                  context,
                                  AppLocalizations.of(context)!
                                      .create_recipe_allergies,
                                  fontSize: 16.sp,
                                ),
                                const Icon(
                                  Icons.info_outline,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),

                          15.verticalSpace,

                          if (widget.filters != null &&
                              widget.filters!.isNotEmpty)
                            SizedBox(
                              height: 40.h,
                              child: ListView.builder(
                                // shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.filters!.length,
                                itemBuilder: (context, index) {
                                  var filter = widget.filters![index];
                                  return Container(
                                    padding: index == 0
                                        ? const EdgeInsets.only(
                                            left: 20,
                                          )
                                        : null,
                                    child: AllergyItem(
                                      title: filter,
                                    ),
                                  );
                                },
                              ),
                            ),
                          // if ((filters == null || filters!.isEmpty) && !isCreateRecipe)
                          //   StandardText.subtitle2(
                          //     context,
                          //     'No allergies added',
                          //   ),
                          if (widget.companyId != null &&
                              allergiesState.allergies.isNotEmpty)
                            SizedBox(
                              height: 40.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: allergiesState.allergies.length,
                                itemBuilder: (context, index) {
                                  String allergy =
                                      allergiesState.allergies[index];
                                  return Container(
                                    padding: index == 0
                                        ? const EdgeInsets.only(
                                            left: 20,
                                          )
                                        : null,
                                    child: AllergyItem(
                                      title: allergy,
                                      color: AppColors.gray200,
                                      textColor: AppColors.black,
                                    ),
                                  );
                                },
                              ),
                            ),

                          if (widget.isCreateRecipe)
                            BlocBuilder<GetChildrenBloc, GetChildrenState>(
                              builder: (context, state) {
                                return (state is GettingChildren)
                                    ? const SizedBox.shrink()
                                    : (state is ErrorGettingChildren)
                                        ? const SizedBox.shrink()
                                        : (state is ChildrenFetched)
                                            ? SizedBox(
                                                height: 40.h,
                                                child: ListView.builder(
                                                  // shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: allergiesState
                                                      .allergies.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    String allergy =
                                                        allergiesState
                                                            .allergies[index];
                                                    return InkWell(
                                                      onTap: () {
                                                        // print(
                                                        //     'this button is pressed');
                                                        // List<Child> children =
                                                        //     [];
                                                        // for (var child in state.children) {
                                                        //   if (child.allergies != null) {
                                                        //     for (var childAllergy in child.allergies!) {
                                                        //       if (childAllergy.toLowerCase() == allergy.toLowerCase()) {
                                                        //         children.add(child);
                                                        //       }
                                                        //     }
                                                        //   }
                                                        // }
                                                        // showAppModal(
                                                        //   context: context,
                                                        //   builder:
                                                        //       (bottomContext) {
                                                        //     return CommonBottomSheet(
                                                        //       height: context
                                                        //               .height *
                                                        //           .65,
                                                        //       child:
                                                        //           ChildrenWithAllergiesSheet(
                                                        //         children:
                                                        //             children,
                                                        //             allergyName: allergy,
                                                        //       ),
                                                        //     );
                                                        //   },
                                                        // );
                                                      },
                                                      child: Container(
                                                        padding: index == 0
                                                            ? const EdgeInsets.only(
                                                                left: 20,
                                                              )
                                                            : null,
                                                        child: AllergyItem(
                                                          title: allergy,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              )
                                            : const SizedBox.shrink();
                              },
                            ),

                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink();
      },
    );
  }
}
