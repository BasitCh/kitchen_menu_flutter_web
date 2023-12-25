import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/login/cubits/login_cubit.dart';
import 'package:menumaster_manager/application/login/login_bloc/login_bloc.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/presentation/login/widgets/email_input.dart';
import 'package:menumaster_manager/presentation/login/widgets/login_button.dart';
import 'package:menumaster_manager/presentation/login/widgets/forgot_password.dart';
import 'package:menumaster_manager/presentation/login/widgets/password_input.dart';
import 'package:widgets_book/widgets_book.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key, required this.password, required this.email})
      : super(key: key);
  final TextEditingController password;
  final TextEditingController email;
  final _formKey = GlobalKey<FormState>();
  final toasts = Toasts();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginError) {
              toasts.showWebToast(
                context,
                width: context.width / 4,
                type: AlertType.Error,
                title: AppLocalizations.of(context)!.common_error,
                description: state.message,
              );
            } else if (state is LoggedIn) {
              getIt<NavigationService>().replaceWithNamed(
                  context: context, uri: NavigationService.dashBoardUri);
            } else if (state is UserProfileMissing) {
              getIt<NavigationService>().replaceWithNamed(
                  context: context, uri: NavigationService.setupProfileUri);
            } else if (state is CompanyProfileMissing) {
              getIt<NavigationService>().replaceWithNamed(
                  context: context,
                  uri: NavigationService.setupCompanyProfileUri);
            }
          },
          child: BlocBuilder<LoginCubit, LoginCubitState>(
            builder: (context, state) {
              return Column(
                children: <Widget>[
                  30.verticalGap,
                  EmailInput(
                    email: email,
                    isEmailValidated: state.isEmailValidated,
                  ),
                  10.verticalGap,
                  PasswordInput(
                    password: password,
                    isObscureText: state.isPasswordObscureText,
                    isPasswordValidated: state.isPasswordValidated,
                  ),
                  25.verticalGap,
                  SizedBox(
                    width: kIsWeb ? context.width / 4 : context.width * 3,
                    child: LoginButton(
                      email: email.text.trim(),
                      password: password.text.trim(),
                      formKey: _formKey,
                    ),
                  ),
                  25.verticalSpace,
                  ForgotPasswordText(
                    onTap: () {
                      context.go('/${NavigationService.forgotPasswordUri}');
                    },
                  ),
                  10.verticalGap,
                ],
              );
            },
          ),
        ));
  }
}
