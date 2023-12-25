import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/profile/cubits/countries_cubit.dart';
import 'package:menumaster_manager/application/profile/cubits/country_state_cubit.dart';
import 'package:menumaster_manager/application/profile/cubits/profile_file_cubit.dart';
import 'package:menumaster_manager/application/profile/cubits/selected_country_cubit.dart';
import 'package:menumaster_manager/application/profile/cubits/selected_state_cubit.dart';
import 'package:menumaster_manager/application/profile/setup_profile_bloc/setup_profile_bloc.dart';
import 'package:menumaster_manager/domain/profile/company.dart';
import 'package:menumaster_manager/domain/profile/setup_profile_form_model.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:widgets_book/widgets_book.dart';

import 'widgets/setup_profile_address.dart';
import 'widgets/setup_phone_info.dart';

class SetupProfileForm extends StatefulWidget {
  const SetupProfileForm({
    Key? key,
    this.isCompanyProfile = false,
    this.user,
    this.company,
    required this.setupProfileFormModel,
  }) : super(key: key);
  final SetupProfileFormModel setupProfileFormModel;
  final bool isCompanyProfile;
  final AppUser? user;
  final Company? company;

  @override
  State<SetupProfileForm> createState() => _SetupProfileFormState();
}

class _SetupProfileFormState extends State<SetupProfileForm> {
  @override
  void initState() {
    super.initState();
    initCountries();
  }

  String countrySelected = '';
  String countryState = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetupProfileBloc, SetupProfileState>(
      listener: (context, state) {
        if (state is ErrorUpdatingProfile) {
          getIt<Toasts>().showWebToast(
            context,
            width: context.width / 4,
            type: AlertType.Error,
            title: AppLocalizations.of(context)!.common_error,
            description: state.message,
          );
        } else if (state is ProfileUpdated) {
          if (state.isUpdatingOldUser!) {
            getIt<NavigationService>().replaceWithNamed(
                context: context, uri: NavigationService.dashBoardUri);
          } else {
            context.read<SetupProfileBloc>().add(CheckManagerProfiles());
          }
        } else if (state is CompanyCreated) {
          if (state.isUpdatingOldCompany!) {
            getIt<NavigationService>().replaceWithNamed(
                context: context, uri: NavigationService.dashBoardUri);
          } else {
            context.read<SetupProfileBloc>().add(CheckManagerProfiles());
          }
        } else if (state is CompanyProfileMissing) {
          getIt<NavigationService>().replaceWithNamed(
            context: context,
            uri: NavigationService.setupCompanyProfileUri,
          );
        } else if (state is UserProfileMissing) {
          getIt<NavigationService>().replaceWithNamed(
            context: context,
            uri: NavigationService.setupProfileUri,
          );
        } else if (state is AllProfilesUpdated) {
          getIt<Toasts>().showWebToast(
            context,
            width: context.width / 4,
            type: AlertType.Success,
            title: AppLocalizations.of(context)!.common_success,
            description: 'Profiles updated successfully',
          );
          getIt<NavigationService>().replaceWithNamed(
              context: context, uri: NavigationService.loginRouteUri);
        }
      },
      child: Form(
        key: widget.setupProfileFormModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SetupProfileAddress(
              isCompanyProfile: widget.isCompanyProfile,
              fullNameTextEditingController:
                  widget.setupProfileFormModel.fullNameTextEditingController,
              streetAddressTextEditingController: widget
                  .setupProfileFormModel.streetAddressTextEditingController,
              onCountrySelection: (country) {
                countrySelected = country;
              },
              onStateSelection: (state) {
                countryState = state;
              },
            ),
            20.verticalSpace,
            SetupPhoneInfo(
              phoneTextEditingController:
                  widget.setupProfileFormModel.phoneNoTextEditingController,
            ),
            20.verticalSpace,
            StandardText.headline6(
              context,
              AppLocalizations.of(context)!.setup_profile_about,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
            11.verticalSpace,
            Row(
              children: [
                Flexible(
                  flex: 6,
                  child: AppTextField(
                    controller:
                        widget.setupProfileFormModel.aboutTextEditingController,
                    maxLength: 500,
                    maxLines: 1,
                    labelText: AppLocalizations.of(context)!
                        .setup_profile_tell_more_about_you,
                    validator: (val) {
                      if (val == null || val.length < 3) {
                        return 'Please enter about';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const Spacer(
                  flex: 4,
                )
              ],
            ),
            20.verticalSpace,
            BlocBuilder<SetupProfileBloc, SetupProfileState>(
                builder: (context, state) {
              return (state is UpdatingProfile)
                  ? const AppButtonLoading()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: context.width / 3.2),
                          width: context.width / 4,
                          child: AppButton.darkRed(
                            child: StandardText.headline6(
                              context,
                              AppLocalizations.of(context)!
                                  .setup_profile_save_profile,
                              color: AppColors.white800,
                            ),
                            onPressed: () {
                              late Company company;
                              late AppUser appUser;
                              if (widget.isCompanyProfile) {
                                company = Company(
                                  companyName: widget.setupProfileFormModel
                                      .fullNameTextEditingController.text,
                                  phoneNumber: widget.setupProfileFormModel
                                      .phoneNoTextEditingController.text,
                                  about: widget.setupProfileFormModel
                                      .aboutTextEditingController.text,
                                  address: UserAddress(
                                    countryCode:
                                        countrySelected == 'New Zealand'
                                            ? '+64'
                                            : '+61',
                                    countryName: countrySelected,
                                    state: countryState,
                                    streetAddress: widget
                                        .setupProfileFormModel
                                        .streetAddressTextEditingController
                                        .text,
                                  ),
                                  createdAt: DateTime.now(),
                                );
                                onSaveProfile(company: company);
                              } else {
                                var fullName = widget.setupProfileFormModel
                                    .fullNameTextEditingController.text
                                    .split(' ');
                                appUser = AppUser(
                                    fullName: widget.setupProfileFormModel
                                        .fullNameTextEditingController.text,
                                    phoneNumber: widget.setupProfileFormModel
                                        .phoneNoTextEditingController.text,
                                    address: UserAddress(
                                      countryName: countrySelected,
                                      state: countryState,
                                      streetAddress: widget
                                          .setupProfileFormModel
                                          .streetAddressTextEditingController
                                          .text,
                                    ),
                                    firstName: fullName.first.isNotEmpty
                                        ? fullName.first
                                        : '',
                                    lastName: fullName.last.isNotEmpty
                                        ? fullName.last
                                        : '',
                                    subscriptionType: '',
                                    about: widget.setupProfileFormModel
                                        .aboutTextEditingController.text,
                                    userRole: UserType.Manager.name,
                                    chefRole: ChefType.Individual.name,
                                    subscriptionStatus: '',
                                    createdAt: DateTime.now());
                                onSaveProfile(
                                  appUser: appUser,
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    );
            }),
            50.verticalSpace,
          ],
        ),
      ),
    );
  }

  onSaveProfile({
    AppUser? appUser,
    Company? company,
  }) {
    if (widget.setupProfileFormModel.formKey.currentState!.validate()) {
      if (widget.isCompanyProfile) {
        // updating the company id for old one
        if (widget.company != null) {
          company?.id = widget.company?.id;
        }
        this.context.read<SetupProfileBloc>().add(
              CreateCompany(
                  company: company!,
                  companyLogo: this.context.read<ProfileFileCubit>().state,
                  isUpdatingOldCompany: widget.company != null),
            );
      } else {
        this.context.read<SetupProfileBloc>().add(
              UpdateUserProfile(
                  appUser: appUser!,
                  file: this.context.read<ProfileFileCubit>().state,
                  isUpdatingOldUser: widget.user != null),
            );
      }
    }
  }

  void initCountries() {
    this.context.read<CountriesCubit>().getCountries();
    this.context.read<ProfileFileCubit>().bytesFromPicker = null;
    String country = '';
    String state = '';
    if (widget.user != null) {
      country = widget.user?.address?.countryName ?? '';
      state = widget.user?.address?.state ?? '';
    } else if (widget.company != null) {
      country = widget.company?.address?.countryName ?? '';
      state = widget.company?.address?.state ?? '';
    }
    countrySelected = country;
    countryState = state;
    if (widget.user != null || widget.company != null) {
      this.context.read<SelectedCountryCubit>().emitSelectedCountry(country);
      this.context.read<CountryStatesCubit>().getStates(country);
      this.context.read<SelectedStateCubit>().emitSelectedState(state);
    }
  }
}
