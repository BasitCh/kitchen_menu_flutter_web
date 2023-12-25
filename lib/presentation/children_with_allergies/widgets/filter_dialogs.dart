import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/apply_filters/apply_filters_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/attendance_bloc/attendance_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/filters_bloc/filters_bloc.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/widgets/checkbox_item.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/widgets/day_checkbox.dart';
import 'package:widgets_book/widgets_book.dart';

Future<Object?> showFilters({required BuildContext context}) async {
  return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 1.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Scaffold(
              backgroundColor: AppColors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            getIt<NavigationService>()
                                .navigateBack(context: buildContext);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.black,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          50.verticalGap,
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
                                  context.read<FiltersBloc>().add(
                                        ClearFilters(),
                                      );
                                  context
                                      .read<AttendanceBloc>()
                                      .add(ClearSelectedDays());
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
                          30.verticalSpace,
                          StandardText.subtitle3(
                            context,
                            'ALLERGIES',
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                          ),
                          BlocBuilder<FiltersBloc, FiltersState>(
                            builder: (context, state) {
                              return state is FiltersFetched
                                  ? Wrap(
                                      direction: Axis.horizontal,
                                      children: state.filters.map(
                                        (e) {
                                          return CheckBoxItem(
                                            filter: e,
                                            onChecked: (filter) {
                                              context.read<FiltersBloc>().add(
                                                    ToggleFilter(
                                                        filter: filter),
                                                  );
                                            },
                                          );
                                        },
                                      ).toList())
                                  : Center(
                                      child: StandardText.body2(
                                          context, 'No Filter Found'),
                                    );
                            },
                          ),
                          30.verticalGap,
                          StandardText.subtitle3(
                            context,
                            'WEEKLY ATTENDANCE',
                            color: AppColors.textBlack,
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                          ),
                          BlocBuilder<AttendanceBloc, AttendanceState>(
                            builder: (context, state) {
                              return state is WeekDaysFetched
                                  ? Wrap(
                                      direction: Axis.horizontal,
                                      children: state.days.map(
                                        (e) {
                                          return DayCheckBox(
                                            day: e,
                                            onChecked: (day) {
                                              context
                                                  .read<AttendanceBloc>()
                                                  .add(
                                                    ToggleDay(day: day),
                                                  );
                                            },
                                          );
                                        },
                                      ).toList())
                                  : Center(
                                      child: StandardText.body2(
                                          context, 'No Filter Found'),
                                    );
                            },
                          ),
                          80.verticalGap,
                          Center(
                            child: SizedBox(
                              width: kIsWeb
                                  ? context.width / 5
                                  : context.width / 3,
                              child: AppButton.darkRed(
                                onPressed: () {
                                  getIt<NavigationService>()
                                      .navigateBack(context: buildContext);
                                  final filters = context
                                      .read<FiltersBloc>()
                                      .localFilters
                                      .where((element) =>
                                          element.isSelected == true)
                                      .toList();
                                  final selectedDays = context
                                      .read<AttendanceBloc>()
                                      .localDays
                                      .where((element) =>
                                          element.isSelected == true)
                                      .toList();
                                  context.read<ApplyFiltersBloc>().add(
                                        ApplyFilters(
                                            selectedFilters: filters,
                                            selectedDays: selectedDays),
                                      );
                                },
                                radius: 8,
                                child: StandardText.buttonLarge(
                                  'APPLY FILTERS',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
