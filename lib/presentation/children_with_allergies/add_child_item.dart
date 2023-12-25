import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/add_child_bloc/add_child_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/allergies_bloc/allergies_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/attendance_bloc/attendance_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/filters_bloc/filters_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/get_children_bloc/get_children_bloc.dart';
import 'package:menumaster_manager/domain/children_with_allergies/allergic_filter.dart';
import 'package:menumaster_manager/domain/children_with_allergies/child.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/infrastructure/services/shared_preferences_helper.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/widgets/checkbox_item.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/widgets/day_checkbox.dart';
import 'package:widgets_book/widgets_book.dart';

class AddChildItem extends StatefulWidget {
  const AddChildItem({super.key, this.child});

  final Child? child;

  @override
  State<AddChildItem> createState() => _AddChildItemState();
}

class _AddChildItemState extends State<AddChildItem> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final centerNameController = TextEditingController();
  final roomNameController = TextEditingController();
  final additionalNotesController = TextEditingController();
  final otherFilterController = TextEditingController();
  List<AllergicFilter> allergies = [];
  List<Day> weekDays = [];

  @override
  void initState() {
    super.initState();
    setChild();
  }

  void setChild() {
    if (widget.child != null) {
      final child = widget.child;
      nameController.text = child?.childName ?? '';
      centerNameController.text = child?.centerName ?? '';
      roomNameController.text = child?.roomName ?? '';
      additionalNotesController.text = child?.additionalNotes ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(50),
            width: context.width,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.verticalSpace,
                StandardText.headline6(
                  context,
                  'Enter Details',
                  fontSize: 18,
                ),
                15.verticalGap,
                StandardText.subtitle3(
                  context,
                  'CHILD NAME',
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                8.verticalSpace,
                AppStandardTextField.outlined(
                  controller: nameController,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter the child\'s name';
                    } else if (value.length < 3) {
                      return 'The name should be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                15.verticalSpace,
                StandardText.subtitle3(
                  context,
                  'ROOM NAME',
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                8.verticalSpace,
                AppStandardTextField.outlined(
                  key: UniqueKey(),
                  controller: roomNameController,
                  keyboardType: TextInputType.text,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter the room name';
                    } else if (value.length < 3) {
                      return 'The room name should be at least 3 characters long';
                    }

                    return null;
                  },
                ),
                15.verticalGap,
                StandardText.subtitle3(
                  context,
                  'CENTER NAME',
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                8.verticalSpace,
                AppStandardTextField.outlined(
                  key: UniqueKey(),
                  controller: centerNameController,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter the center name';
                    } else if (value.length < 3) {
                      return 'The center name should be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                15.verticalSpace,
                BlocConsumer<AllergiesBloc, AllergiesState>(
                  listener: (context, state) {
                    if (state is AllergiesFetched) {
                      allergies = state.allergies;
                    } else if (state is AllergiesToggled) {
                      allergies = state.allergies;
                    } else if (state is AllergiesToggledForOldChild) {
                      allergies = state.allergies;
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StandardText.subtitle3(
                          context,
                          'ALLERGIES',
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        8.verticalSpace,
                        Wrap(
                          direction: Axis.horizontal,
                          children: allergies.map(
                            (e) {
                              return CheckBoxItem(
                                filter: e,
                                onChecked: (allergy) {
                                  context.read<AllergiesBloc>().add(
                                        ToggleAllergies(filter: allergy),
                                      );
                                },
                              );
                            },
                          ).toList(),
                        ),
                      ],
                    );
                  },
                ),
                BlocBuilder<AllergiesBloc, AllergiesState>(
                  builder: (context, state) {
                    return context.read<AllergiesBloc>().localFilters.any(
                            (element) =>
                                element.name.toLowerCase() == 'other' &&
                                element.isSelected == true)
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              15.verticalGap,
                              StandardText.subtitle3(
                                context,
                                'OTHER',
                                color: AppColors.textBlack,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                              8.verticalGap,
                              AppStandardTextField.outlined(
                                controller: otherFilterController,
                                key: UniqueKey(),
                                keyboardType: TextInputType.text,
                                maxLines: 4,
                                hintText: 'Describe the filter/allergy here',
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 15),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please enter allergy';
                                  } else if (value.length < 3) {
                                    return 'Allergy should be at least 3 characters long';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          )
                        : const SizedBox.shrink();
                  },
                ),
                15.verticalGap,
                BlocConsumer<AttendanceBloc, AttendanceState>(
                  listener: (context, state) {
                    if (state is WeekDaysFetched) {
                      weekDays = state.days;
                    } else if (state is DaysToggledForOldChild) {
                      weekDays = state.selectedDays;
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StandardText.subtitle3(
                          context,
                          'WEEKLY ATTENDANCE',
                          color: AppColors.textBlack,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        8.verticalSpace,
                        Wrap(
                          direction: Axis.horizontal,
                          children: weekDays.map(
                            (e) {
                              return DayCheckBox(
                                day: e,
                                onChecked: (day) {
                                  context.read<AttendanceBloc>().add(
                                        ToggleDay(day: day),
                                      );
                                },
                              );
                            },
                          ).toList(),
                        ),
                        3.verticalGap,
                         isAttendanceNotSelected()
                            ? const Text(
                                'Select the attendance',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 11,
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    );
                  },
                ),
                15.verticalGap,
                StandardText.subtitle3(
                  context,
                  'ADDITIONAL NOTES',
                  color: AppColors.textBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
                8.verticalSpace,
                AppStandardTextField.outlined(
                  controller: additionalNotesController,
                  key: UniqueKey(),
                  keyboardType: TextInputType.text,
                  maxLines: 4,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
                  validator: (value) {
                    if (value == null) {
                      return 'Please enter additional notes';
                    } else if (value.length < 3) {
                      return 'Notes should be at least 3 characters long';
                    }
                    return null;
                  },
                ),
                30.verticalGap
              ],
            ),
          ),
          50.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                  width: kIsWeb ? context.width / 5 : context.width / 3,
                  child: BlocListener<AddChildBloc, AddChildState>(
                    listener: ((context, state) {
                      if (state is ChildAdded) {
                        context.read<GetChildrenBloc>().add(GetChildren());
                        getIt<NavigationService>()
                            .navigateBack(context: context);
                      } else if (state is ErrorAddingChild) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              content: StandardText.headline1(
                                context,
                                state.error,
                                fontSize: 12,
                                color: AppColors.white,
                              ),
                            ),
                          );
                      }
                    }),
                    child: MultiBlocListener(
                      listeners: [
                        BlocListener<AllergiesBloc, AllergiesState>(
                            listener: (context, state) {
                          if (state is AllergiesFetched) {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              if (widget.child != null) {
                                this.context.read<AllergiesBloc>().add(
                                    ToggleAlreadySelectedAllergies(
                                        allergies:
                                            widget.child?.allergies ?? []));
                              }
                            });
                          } else if (state is AllergyAdded) {
                            context.read<AllergiesBloc>().add(
                                  GetAllergies(),
                                );
                            context.read<FiltersBloc>().add(
                                  GetFilters(),
                                );
                          }
                        })
                      ],
                      child: BlocBuilder<AddChildBloc, AddChildState>(
                        builder: (context, state) {
                          return (state is AddingChild)
                              ? const AppButtonLoading()
                              : AppButton.darkRed(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate() &&
                                        !isAttendanceNotSelected()) {
                                      final appUser =
                                          await SharedPreferenceService
                                              .getUser();
                                      if (!mounted) return;

                                      // check if otherController.text.isNotEmpty
                                      // then add it to the allergies collection
                                      List<String> allergies = context
                                          .read<AllergiesBloc>()
                                          .localFilters
                                          .where((element) =>
                                              element.isSelected! &&
                                              element.name.toLowerCase() !=
                                                  'other')
                                          .map((e) => e.name)
                                          .toList();
                                      if (otherFilterController
                                          .text.isNotEmpty) {
                                        allergies
                                            .add(otherFilterController.text);
                                        context
                                            .read<AllergiesBloc>()
                                            .localFilters
                                            .add(AllergicFilter(
                                                name: otherFilterController
                                                    .text));
                                        context.read<AllergiesBloc>().add(
                                              AddOtherAllergy(
                                                allergies: context
                                                    .read<AllergiesBloc>()
                                                    .localFilters
                                                    .where((element) =>
                                                        element.name
                                                            .toLowerCase() !=
                                                        'other')
                                                    .map((e) => e.name)
                                                    .toSet()
                                                    .toList(),
                                              ),
                                            );
                                      }
                                      //

                                      final child = Child(
                                          childName: nameController.text.trim(),
                                          roomName:
                                              roomNameController.text.trim(),
                                          centerName:
                                              centerNameController.text.trim(),
                                          additionalNotes:
                                              additionalNotesController.text
                                                  .trim(),
                                          createdAt: DateTime.now(),
                                          allergies: allergies,
                                          weeklyAttendance: context
                                              .read<AttendanceBloc>()
                                              .localDays
                                              .where((element) =>
                                                  element.isSelected!)
                                              .map((e) => e.name)
                                              .toList(),
                                          companyId: appUser?.companyId ?? '',
                                          companyName:
                                              appUser?.companyName ?? '');

                                      if (widget.child != null) {
                                        child.childId = widget.child?.childId;
                                        context
                                            .read<AddChildBloc>()
                                            .add(UpdateChild(child: child));
                                      } else {
                                        context
                                            .read<AddChildBloc>()
                                            .add(AddChild(child: child));
                                      }
                                    }
                                  },
                                  radius: 8,
                                  child: StandardText.buttonLarge(
                                    widget.child != null
                                        ? 'SAVE NOW'
                                        : 'ADD NOW',
                                  ),
                                );
                        },
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  bool isAttendanceNotSelected() {
    return this
        .context
        .read<AttendanceBloc>()
        .localDays
        .where((element) => element.isSelected!)
        .map((e) => e.name)
        .toList()
        .isEmpty;
  }

  @override
  void dispose() {
    nameController.dispose();
    centerNameController.dispose();
    roomNameController.dispose();
    additionalNotesController.dispose();
    otherFilterController.dispose();
    super.dispose();
  }
}
