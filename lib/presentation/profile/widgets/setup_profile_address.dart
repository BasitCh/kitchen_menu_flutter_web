import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/profile/cubits/countries_cubit.dart';
import 'package:menumaster_manager/application/profile/cubits/country_state_cubit.dart';
import 'package:menumaster_manager/application/profile/cubits/selected_country_cubit.dart';
import 'package:menumaster_manager/application/profile/cubits/selected_state_cubit.dart';
import 'package:widgets_book/widgets_book.dart';

class SetupProfileAddress extends StatelessWidget {
  const SetupProfileAddress({
    Key? key,
    this.isCompanyProfile = false,
    required this.streetAddressTextEditingController,
    required this.onCountrySelection,
    required this.fullNameTextEditingController,
    required this.onStateSelection,
  }) : super(key: key);

  final Function(String) onStateSelection;
  final TextEditingController streetAddressTextEditingController;
  final Function(String) onCountrySelection;
  final TextEditingController fullNameTextEditingController;
  final bool? isCompanyProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StandardText.headline6(
            context,
            AppLocalizations.of(context)!.setup_profile_address,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
          5.verticalSpace,
          Row(
            children: [
              Flexible(
                child: AppTextField(
                    controller: fullNameTextEditingController,
                    key: const Key('profile_name'),
                    suffix: Assets.icons.icDone.svg(),
                    labelText: isCompanyProfile! ? 'COMPANY NAME' : 'NAME',
                    textInputAction: TextInputAction.next,
                    validator: (val) {
                      if (val == null || val.length < 3) {
                        return isCompanyProfile!
                            ? 'Please enter company name'
                            : 'Please enter your full name';
                      } else {
                        return null;
                      }
                    }),
              ),
              5.horizontalGap,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      transform: Matrix4.translationValues(0, 6, 0),
                      child: StandardText.subtitle3(
                        context,
                        'Country',
                        color: AppColors.gray,
                      ),
                    ),
                    Container(
                        transform: Matrix4.translationValues(0, 6, 0),
                        child: BlocBuilder<SelectedCountryCubit, String?>(
                          builder: (context, selectedCountry) {
                            return BlocBuilder<CountriesCubit, List<String>>(
                              builder: (context, countries) {
                                String countrySelected = '';
                                if (selectedCountry != null &&
                                    selectedCountry.isNotEmpty) {
                                  countrySelected = countries.singleWhere(
                                      (element) => element == selectedCountry);
                                }
                                return countries.isNotEmpty
                                    ? DropdownButtonFormField<String>(
                                        isExpanded: true,
                                        value: countrySelected.isNotEmpty
                                            ? countrySelected
                                            : null,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 0, vertical: 10),
                                          fillColor: AppColors.transparent,
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: AppColors.lightRed
                                                  .withOpacity(0.3),
                                            ),
                                          ),
                                          focusedBorder: InputBorder.none,
                                        ),
                                        items: countries
                                            .toSet()
                                            .toList()
                                            .map((String item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: StandardText.subtitle3(
                                                context, item),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          if (newValue != null) {
                                            context
                                                .read<CountryStatesCubit>()
                                                .getStates(newValue);
                                            context
                                                .read<SelectedCountryCubit>()
                                                .emitSelectedCountry(
                                                  newValue.toString(),
                                                );
                                            onCountrySelection(newValue);
                                          }
                                        },
                                        validator: (val) {
                                          if (val == null || val.isEmpty) {
                                            return 'Please select your country';
                                          } else {
                                            return null;
                                          }
                                        },
                                      )
                                    : const ShimmerContainer(
                                        type: ShimmerType.square,
                                        height: 45,
                                      );
                              },
                            );
                          },
                        )),
                  ],
                ),
              ),
              5.horizontalGap,
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      transform: Matrix4.translationValues(0, 6, 0),
                      child: StandardText.subtitle3(
                        context,
                        'State',
                        color: AppColors.gray,
                      ),
                    ),
                    Container(
                        transform: Matrix4.translationValues(0, 6, 0),
                        child: BlocBuilder<SelectedStateCubit, String?>(
                          builder: (context, selectedState) {
                            return BlocBuilder<CountryStatesCubit,
                                List<String>>(
                              builder: (context, state) {
                                return DropdownButtonFormField<String>(
                                  // hint: StandardText.subtitle3(
                                  //     context, 'Select State/Region'),
                                  isExpanded: true,

                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 10),
                                    fillColor: AppColors.transparent,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            AppColors.lightRed.withOpacity(0.3),
                                      ),
                                    ),
                                    focusedBorder: InputBorder.none,
                                  ),
                                  value: selectedState != null &&
                                          selectedState.isNotEmpty
                                      ? state.contains(selectedState)
                                          ? state.singleWhere((element) =>
                                              element == selectedState)
                                          : state[0]
                                      : null,
                                  items: state.isEmpty
                                      ? []
                                      : state
                                          .toSet()
                                          .toList()
                                          .map((String item) {
                                          return DropdownMenuItem(
                                            value: item,
                                            child: StandardText.subtitle3(
                                                context, item),
                                          );
                                        }).toList(),
                                  onChanged: (String? newValue) {
                                    if (newValue != null) {
                                      context
                                          .read<SelectedStateCubit>()
                                          .emitSelectedState(newValue);
                                      onStateSelection(newValue);
                                    }
                                  },
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Please select State/Region';
                                    } else {
                                      return null;
                                    }
                                  },
                                );
                              },
                            );
                          },
                        )),
                  ],
                ),
              ),
              5.horizontalGap,
              Flexible(
                flex: 1,
                child: AppTextField(
                  controller: streetAddressTextEditingController,
                  labelText: context.width < 1500
                      ? 'STREET ADDRESS'
                      : 'STREET ADDRESS (OPTIONAL)',
                  textInputAction: TextInputAction.next,
                ),
              ),
              const Spacer(
                flex: 2,
              )
            ],
          ),
        ],
      ),
    );
  }
}
