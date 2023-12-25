import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/signup/signup_bloc/signup_bloc.dart';
import 'package:menumaster_manager/application/signup/signup_cubit/signup_cubit.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/infrastructure/signup/signup_repository.dart';
import 'package:menumaster_manager/presentation/signup/signup_form.dart';
import 'package:widgets_book/widgets_book.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late TextEditingController emailTextEditingController;
  late TextEditingController passwordTextEditingController;
  late TextEditingController confirmPasswordTextEditingController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Toasts toasts = Toasts();

  @override
  void initState() {
    emailTextEditingController = TextEditingController();
    passwordTextEditingController = TextEditingController();
    confirmPasswordTextEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    confirmPasswordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignupCubit(),
          ),
          BlocProvider(
            create: (context) => SignupBloc(
              signupRepository:
                  RepositoryProvider.of<SignupRepository>(context),
            ),
          )
        ],
        child: BlocListener<SignupBloc, RegisterState>(
          listener: (context, state) {
            if (state is Signedup) {
              toasts.showWebToast(
                context,
                 width: context.width / 4,
                type: AlertType.Info,
                title: AppLocalizations.of(context)!.signup_verify_your_email,
                description: AppLocalizations.of(context)!
                    .signup_an_email_verification_link_sent,
                prefixWidget: Assets.icons.emailSent.svg(
                  width: 31.h,
                  fit: BoxFit.scaleDown,
                ),
              );
              getIt<NavigationService>().replaceWithNamed(
                context: context,
                uri: NavigationService.registrationSuccessUri,
              );
            } else if (state is ErrorSigningup) {
              toasts.showWebToast(
                context,
                 width: context.width / 4,
                type: AlertType.Error,
                title: AppLocalizations.of(context)!.common_error,
                description: state.error,
              );
            }
          },
          child: SingleChildScrollView(
            child: AutofillGroup(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  30.verticalSpace,
                  Assets.images.appLogoPng.image(height: 184, width: 184),
                  20.verticalGap,
                  StandardText.headline3(
                    context,
                    'Create Company Account',
                    fontWeight: FontWeight.w300,
                    fontSize: 44,
                    color: AppColors.textBlack80,
                    align: TextAlign.center,
                  ),
                  10.verticalGap,
                  StandardText.headline1(
                    context,
                    'Email and Password for sign up',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    fontFamily: Assets.fonts.poppinsRegular,
                    color: AppColors.textBlack60,
                    align: TextAlign.center,
                  ),
                  InkWell(
                    onTap: () {
                      getIt<NavigationService>().replaceWithNamed(
                        context: context,
                        uri: NavigationService.loginRouteUri,
                      );
                    },
                    child: StandardText.underline(
                      context,
                      'Already have account?',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.black,
                      align: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: context.width,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 43),
                      child: SignupForm(
                        formKey: _formKey,
                        emailTextEditingController: emailTextEditingController,
                        passwordTextEditingController:
                            passwordTextEditingController,
                        confirmPasswordTextEditingController:
                            confirmPasswordTextEditingController,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
