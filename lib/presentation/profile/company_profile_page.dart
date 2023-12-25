import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/profile/cubits/countries_cubit.dart';
import 'package:menumaster_manager/application/profile/cubits/country_state_cubit.dart';
import 'package:menumaster_manager/application/profile/cubits/profile_file_cubit.dart';
import 'package:menumaster_manager/application/profile/cubits/selected_country_cubit.dart';
import 'package:menumaster_manager/application/profile/cubits/selected_state_cubit.dart';
import 'package:menumaster_manager/application/profile/setup_profile_bloc/setup_profile_bloc.dart';
import 'package:menumaster_manager/domain/profile/company.dart';
import 'package:menumaster_manager/domain/profile/setup_profile_form_model.dart';
import 'package:menumaster_manager/infrastructure/profile/profile_repository.dart';
import 'package:menumaster_manager/presentation/profile/setup_profile_form.dart';
import 'package:menumaster_manager/presentation/profile/widgets/profile_stepper.dart';
import 'package:menumaster_manager/presentation/profile/widgets/setup_profile_upload_photo.dart';
import 'package:widgets_book/widgets_book.dart';

class CompanyProfilePage extends StatefulWidget {
  const CompanyProfilePage({super.key, this.company});

  final Company? company;

  @override
  State<CompanyProfilePage> createState() => _CompanyProfilePageState();
}

class _CompanyProfilePageState extends State<CompanyProfilePage> {
  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController phoneNoTextEditingController = TextEditingController();
  TextEditingController streetAddressTextEditingController =
      TextEditingController();
  TextEditingController aboutTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setCompany();
  }

  @override
  void dispose() {
    disposeTextControllers();
    super.dispose();
  }

  disposeTextControllers() {
    fullNameTextEditingController.dispose();
    phoneNoTextEditingController.dispose();
    streetAddressTextEditingController.dispose();
    aboutTextEditingController.dispose();
  }

  void setCompany() {
    if (widget.company != null) {
      fullNameTextEditingController.text = widget.company?.companyName ?? '';
      phoneNoTextEditingController.text = widget.company?.phoneNumber ?? '';
      streetAddressTextEditingController.text =
          widget.company?.address?.streetAddress ?? '';
      aboutTextEditingController.text = widget.company?.about ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileFileCubit(),
        ),
        BlocProvider(
          create: (create) => CountriesCubit(),
        ),
        BlocProvider(
          create: (create) => SelectedCountryCubit(),
        ),
        BlocProvider(
          create: (create) => SelectedStateCubit(),
        ),
        BlocProvider(
          create: (create) => CountryStatesCubit(),
        ),
        BlocProvider(
            create: (context) => SetupProfileBloc(
                  profileRepository:
                      RepositoryProvider.of<ProfileRepository>(context),
                ))
      ],
      child: BaseScaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 80, right: context.width / 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.verticalSpace,
                const BaseTitle(
                  text: 'Setup Company Profile',
                ),
                5.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseSubtitle(
                      text: AppLocalizations.of(context)!
                          .setup_profile_enter_the_required_information_to_complete,
                    ),
                    if (widget.company == null) ...[
                      context.width > 900
                          ? const ProfileStepper(
                              currentStep: 1,
                            )
                          : const SizedBox.shrink(),
                    ]
                  ],
                ),
                if (context.width < 900) ...[
                  15.verticalSpace,
                  const ProfileStepper(
                    currentStep: 1,
                  )
                ],
                32.verticalSpace,
                SetupProfileUploadPhoto(
                  isCompanyProfile: true,
                  comapany: widget.company,
                ),
                35.verticalSpace,
                SetupProfileForm(
                  isCompanyProfile: true,
                  company: widget.company,
                  setupProfileFormModel: SetupProfileFormModel(
                    fullNameTextEditingController:
                        fullNameTextEditingController,
                    phoneNoTextEditingController:
                        phoneNoTextEditingController,
                    streetAddressTextEditingController:
                        streetAddressTextEditingController,
                    aboutTextEditingController: aboutTextEditingController,
                    formKey: formKey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
