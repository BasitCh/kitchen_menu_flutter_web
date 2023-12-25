import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/login/login_bloc/login_bloc.dart';
import 'package:widgets_book/widgets_book.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.password,
    required this.email,
    required this.formKey,
  });

  final String password;
  final String email;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return (state is LoggingIn)
            ? const AppButtonLoading()
            : AppButton.darkRed(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StandardText.buttonLarge(
                      AppLocalizations.of(context)!.login_sign_in.toUpperCase(),
                    ),
                    // 6.horizontalSpace,
                    // Assets.icons.arrowRight.svg(),
                  ],
                ),
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  if (formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(
                          Login(
                            email: email,
                            password: password,
                          ),
                        );
                  }
                },
              );
      },
    );
  }
}
