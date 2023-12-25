part of 'login_cubit.dart';

class LoginCubitState {
  LoginCubitState({
    this.isEmailValidated = true,
    this.isPasswordObscureText = true,
    this.isPasswordValidated = true,
  });

  final bool isEmailValidated;
  final bool isPasswordValidated;
  final bool isPasswordObscureText;

  LoginCubitState copyWith({
    bool? isEmailValidated,
    bool? isPasswordValidated,
    bool? isPasswordObscureText,
  }) =>
      LoginCubitState(
        isEmailValidated: isEmailValidated ?? this.isEmailValidated,
        isPasswordValidated: isPasswordValidated ?? this.isPasswordValidated,
        isPasswordObscureText:
            isPasswordObscureText ?? this.isPasswordObscureText,
      );
}
