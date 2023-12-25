// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit()
      : super(
          SignupState(),
        );

  void emitEmail(bool value) {
    emit(state.copyWith(isEmailValidated: value));
  }

  void emitPassword(bool value) {
    emit(
      state.copyWith(
        isPasswordValidated: value,
      ),
    );
  }

  void emitConfirmPassword(bool value) {
    emit(
      state.copyWith(
        isConfirmPasswordValidated: value,
      ),
    );
  }

  void obscurePassword(bool value) {
    emit(
      state.copyWith(
        isPasswordObscureText: value,
      ),
    );
  }

  void obscureConfirmPassword(bool value) {
    emit(
      state.copyWith(
        isConfirmPasswordObscureText: value,
      ),
    );
  }

  String? validateEmail(
    String? val,
  ) {
    const emailRegex =
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
    if (val == null || val.isEmpty) {
      emitEmail(false);
      return 'Please enter your email address';
    } else if (!RegExp(emailRegex).hasMatch(val)) {
      emitEmail(false);
      return 'The email you entered is invalid';
    } else {
      emitEmail(true);
      return null;
    }
  }

  String? validatePassword(
    String? val,
  ) {
    if (val == null || val.isEmpty) {
      emitPassword(false);
      return 'Please enter new password';
    } else if (val.length < 8) {
      emitPassword(false);
      return 'Password must be of 8 characters';
    } else {
      emitPassword(true);
      return null;
    }
  }

  String? validateConfirmPassword({
    required String password,
    required String confirmPassword,
  }) {
    if (password.isEmpty) {
      emitConfirmPassword(false);
      return 'Please confirm password';
    } else if (password != confirmPassword) {
      emitConfirmPassword(false);
      return 'Confirm password not matched';
    } else {
      emitConfirmPassword(true);
      return null;
    }
  }
}
