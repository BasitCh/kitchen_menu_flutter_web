import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:menumaster_manager/application/forgot_password/forgot_passsword_bloc.dart";
import "package:menumaster_manager/application/signup/signup_cubit/signup_cubit.dart";
import "package:menumaster_manager/infrastructure/di/injectable.dart";
import "package:menumaster_manager/infrastructure/login/login_repository.dart";
import "package:menumaster_manager/infrastructure/services/navigation_service.dart";
import "package:widgets_book/widgets_book.dart";

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignupCubit(),
        ),
        BlocProvider(
          create: (context) => ForgotPassswordBloc(
            loginRepository: RepositoryProvider.of<LoginRepository>(context),
          ),
        )
      ],
      child: const BaseScaffold(body: ForgotPasswordUI()),
    );
  }
}

class ForgotPasswordUI extends StatefulWidget {
  const ForgotPasswordUI({super.key});

  @override
  State<ForgotPasswordUI> createState() => _ForgotPasswordUIState();
}

class _ForgotPasswordUIState extends State<ForgotPasswordUI> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPassswordBloc, ForgotPassswordState>(
      listener: (context, state) {
        if (state is PasswordSent) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: StandardText.headline1(
                  context,
                  'Password reset email has been sent',
                  fontSize: 12,
                  color: AppColors.white,
                ),
              ),
            );
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            getIt<NavigationService>().replaceWithNamed(
                context: context, uri: NavigationService.loginRouteUri);
          });
        } else if (state is ErrorSendingEmail) {
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
      },
      child: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                30.verticalSpace,
                Assets.images.appLogoPng.image(height: 184, width: 184),
                20.verticalGap,
                StandardText.headline3(
                  context,
                  'Forgot Password',
                  fontWeight: FontWeight.w300,
                  fontSize: 44,
                  color: AppColors.textBlack80,
                  align: TextAlign.center,
                ),
                10.verticalGap,
                StandardText.headline1(
                  context,
                  'Enter your email to reset the password',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  fontFamily: Assets.fonts.poppinsRegular,
                  color: AppColors.textBlack60,
                  align: TextAlign.center,
                ),
                10.verticalGap,
                SizedBox(
                  width: context.width / 4,
                  child: BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                    return AppTextField(
                      controller: emailController,
                      key: const Key('loginForm_email'),
                      suffix: state.isEmailValidated
                          ? Assets.icons.icDone.svg()
                          : crossIcon(),
                      labelText: 'EMAIL ADDRESS',
                      validator: (value) =>
                          context.read<SignupCubit>().validateEmail(value),
                    );
                  }),
                ),
                10.verticalGap,
                SizedBox(
                    width: kIsWeb ? context.width / 4 : context.width * 3,
                    child:
                        BlocBuilder<ForgotPassswordBloc, ForgotPassswordState>(
                      builder: (context, state) {
                        return state is SendingEmail
                            ? const AppButtonLoading()
                            : AppButton.darkRed(
                                child: StandardText.buttonLarge(
                                    'Reset the password'),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<ForgotPassswordBloc>().add(
                                          SendPasswordResetEmail(
                                              email: emailController.text.trim()),
                                        );
                                  }
                                },
                              );
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget crossIcon() {
    return const Icon(
      Icons.close,
      color: AppColors.accent,
      size: 25,
    );
  }
}
