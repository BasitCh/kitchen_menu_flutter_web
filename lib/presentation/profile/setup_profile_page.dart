import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/profile/cubits/countries_cubit.dart';
import 'package:menumaster_manager/application/profile/cubits/country_state_cubit.dart';
import 'package:menumaster_manager/application/profile/cubits/profile_file_cubit.dart';
import 'package:menumaster_manager/application/profile/cubits/selected_country_cubit.dart';
import 'package:menumaster_manager/application/profile/cubits/selected_state_cubit.dart';
import 'package:menumaster_manager/application/profile/setup_profile_bloc/setup_profile_bloc.dart';
import 'package:menumaster_manager/domain/profile/setup_profile_form_model.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/infrastructure/profile/profile_repository.dart';
import 'package:menumaster_manager/presentation/profile/setup_profile_form.dart';
import 'package:menumaster_manager/presentation/profile/widgets/profile_stepper.dart';
import 'package:menumaster_manager/presentation/profile/widgets/setup_profile_upload_photo.dart';
import 'package:widgets_book/widgets_book.dart';

class SetupProfilePage extends StatefulWidget {
  const SetupProfilePage({
    Key? key,
    this.user,
  }) : super(key: key);

  final AppUser? user;

  @override
  State<SetupProfilePage> createState() => _SetupProfilePageState();
}

class _SetupProfilePageState extends State<SetupProfilePage> {
  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController phoneNoTextEditingController = TextEditingController();
  TextEditingController streetAddressTextEditingController =
      TextEditingController();
  TextEditingController aboutTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setUser();
  }

  @override
  void dispose() {
    disposeTextControllers();
    super.dispose();
  }

  void setUser() {
    if (widget.user != null) {
      fullNameTextEditingController.text = widget.user?.fullName ?? '';
      phoneNoTextEditingController.text = widget.user?.phoneNumber ?? '';
      streetAddressTextEditingController.text =
          widget.user?.address?.streetAddress ?? '';
      aboutTextEditingController.text = widget.user?.about ?? '';
    }
  }

  disposeTextControllers() {
    fullNameTextEditingController.dispose();
    phoneNoTextEditingController.dispose();
    streetAddressTextEditingController.dispose();
    aboutTextEditingController.dispose();
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
                  text: 'Setup Personal Profile',
                ),
                5.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BaseSubtitle(
                      text: AppLocalizations.of(context)!
                          .setup_profile_enter_the_required_information_to_complete,
                    ),
                    if (widget.user == null) ...[
                      context.width > 900
                          ? const ProfileStepper(
                              currentStep: 2,
                            )
                          : const SizedBox.shrink(),
                    ]
                  ],
                ),
                if (widget.user == null) ...[
                  if (context.width < 900) ...[
                    15.verticalSpace,
                    const ProfileStepper(
                      currentStep: 1,
                    )
                  ],
                ],
                32.verticalSpace,
                SetupProfileUploadPhoto(
                  user: widget.user,
                ),
                35.verticalSpace,
                SetupProfileForm(
                  user: widget.user,
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
