part of 'signup_cubit.dart';

class SignupState {
  SignupState({
    this.isEmailValidated = true,
    this.isPasswordObscureText = true,
    this.isConfirmPasswordObscureText = true,
    this.isPasswordValidated = true,
    this.isConfirmPasswordValidated = true,
  });

  final bool isEmailValidated;
  final bool isPasswordValidated;
  final bool isConfirmPasswordValidated;
  final bool isPasswordObscureText;
  final bool isConfirmPasswordObscureText;

  SignupState copyWith({
    bool? isEmailValidated,
    bool? isPasswordValidated,
    bool? isConfirmPasswordValidated,
    bool? isPasswordObscureText,
    bool? isConfirmPasswordObscureText,
  }) =>
      SignupState(
        isEmailValidated: isEmailValidated ?? this.isEmailValidated,
        isPasswordValidated: isPasswordValidated ?? this.isPasswordValidated,
        isConfirmPasswordValidated: isConfirmPasswordValidated?? this.isConfirmPasswordValidated,
        isPasswordObscureText:
            isPasswordObscureText ?? this.isPasswordObscureText,
        isConfirmPasswordObscureText:
            isConfirmPasswordObscureText ?? this.isConfirmPasswordObscureText,
      );
}
