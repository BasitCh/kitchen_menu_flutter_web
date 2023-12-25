import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/apply_filters/apply_filters_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/attendance_bloc/attendance_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/get_children_bloc/get_children_bloc.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/widgets/children_list.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/widgets/filter_card.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/widgets/filter_dialogs.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/widgets/selected_day_item.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/widgets/selected_filter_item.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/widgets/table_header.dart';
import 'package:widgets_book/widgets_book.dart';

class ChildrenWithAllergiesUI extends StatefulWidget {
  const ChildrenWithAllergiesUI({super.key});

  @override
  State<ChildrenWithAllergiesUI> createState() =>
      _ChildrenWithAllergiesUIState();
}

class _ChildrenWithAllergiesUIState extends State<ChildrenWithAllergiesUI> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.verticalGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StandardText.headline1(
                  context,
                  'ALL CHILDREN',
                  fontFamily: Assets.fonts.yugothicLight,
                  fontSize: 40,
                  fontWeight: FontWeight.w300,
                  color: AppColors.textBlack80,
                  align: TextAlign.start,
                ),
                Row(
                  children: [
                    StandardText.body2(context, 'ADD NEW CHILD',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack),
                    3.horizontalGap,
                    FloatingActionButton(
                      onPressed: () {
                        getIt<NavigationService>().navigateToNamed(
                            context: context,
                            uri: NavigationService.addChildUri);
                      },
                      backgroundColor: AppColors.hoverColor,
                      child: const Icon(
                        Icons.add,
                        color: AppColors.accent,
                      ),
                    ),
                  ],
                )
              ],
            ),
            30.verticalGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilterCard(
                  onTap: () async {
                    context.read<AttendanceBloc>().add(GetWeekDays());
                    await showFilters(context: context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StandardText.body2(
                        context,
                        'Filters',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textBlack,
                      ),
                      50.horizontalGap,
                      Assets.icons.filterBlack.svg(),
                    ],
                  ),
                ),
              ],
            ),
            BlocListener<ApplyFiltersBloc, ApplyFiltersState>(
              listener: (context, state) {
                if (state is AppliedFilters) {
                  if ((state.filters != null && state.filters!.isNotEmpty) ||
                      (state.selectedDays != null &&
                          state.selectedDays!.isNotEmpty)) {
                    context.read<GetChildrenBloc>().add(GetFilteredChildren(
                        selectedFilters: state.filters ?? [],
                        selectedDays: state.selectedDays ?? []));
                  } else {
                    context.read<GetChildrenBloc>().add(RestoreLocalChildren());
                  }
                }
              },
              child: BlocBuilder<ApplyFiltersBloc, ApplyFiltersState>(
                builder: (context, state) {
                  return state is AppliedFilters
                      ? (state.filters != null && state.filters!.isNotEmpty) ||
                              (state.selectedDays != null &&
                                  state.selectedDays!.isNotEmpty)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                30.verticalGap,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    StandardText.body2(
                                        this.context, 'APPLIED FILTERS',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.textBlack),
                                    MaterialButton(
                                      onPressed: () {
                                        context.read<ApplyFiltersBloc>().add(
                                              ClearAppliedFilters(),
                                            );

                                        context
                                            .read<GetChildrenBloc>()
                                            .add(RestoreLocalChildren());
                                      },
                                      child: StandardText.subtitle3(
                                        context,
                                        'CLEAR FILTERS',
                                        color: AppColors.accent,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                ),
                                5.verticalGap,
                                state.filters != null &&
                                        state.filters!.isNotEmpty
                                    ? Wrap(
                                        children: state.filters!
                                            .map(
                                              (e) => SelectedFilterItem(
                                                filter: e,
                                              ),
                                            )
                                            .toList(),
                                      )
                                    : const SizedBox(),
                                5.verticalGap,
                                state.selectedDays != null &&
                                        state.selectedDays!.isNotEmpty
                                    ? Wrap(
                                        children: state.selectedDays!
                                            .map(
                                              (e) => SelectedDayItem(
                                                filter: e,
                                              ),
                                            )
                                            .toList(),
                                      )
                                    : const SizedBox.shrink()
                              ],
                            )
                          : const SizedBox.shrink()
                      : const SizedBox.shrink();
                },
              ),
            ),
            30.verticalGap,
            BlocBuilder<GetChildrenBloc, GetChildrenState>(
              builder: (context, state) {
                return state is GettingChildren
                    ? const SizedBox(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : (state is ChildrenFetched)
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 20),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(3, 2),
                                ),
                              ],
                            ),
                            child: ListView(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              children: [
                                const TableHeader(),
                                const AppDivider(),
                                ChildrenList(children: state.children),
                                10.verticalSpace,
                              ],
                            ),
                          )
                        : (state is NoChildrenFound)
                            ? SizedBox(
                                height: 200,
                                child: Center(
                                  child: StandardText.headline4(
                                    context,
                                    'No children found, Add new',
                                    color: AppColors.accent,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink();
              },
            ),
            50.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: kIsWeb ? context.width / 5 : context.width / 3,
                  child: AppButton.darkRed(
                    onPressed: () {
                      getIt<NavigationService>().navigateToNamed(
                          context: context, uri: NavigationService.addChildUri);
                    },
                    radius: 8,
                    child: StandardText.buttonLarge(
                      'ADD NEW CHILD',
                    ),
                  ),
                ),
              ],
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
