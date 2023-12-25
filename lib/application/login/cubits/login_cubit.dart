// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit()
      : super(
          LoginCubitState(),
        );

  void isValidatedEmail(bool value) {
    emit(state.copyWith(isEmailValidated: value));
  }

  void isValidatedPassword(bool value) {
    emit(
      state.copyWith(
        isPasswordValidated: value,
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

  String? validateEmail(
    String? val,
  ) {
    const emailRegex =
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
    if (val == null || val.isEmpty) {
      isValidatedEmail(false);
      return 'Please enter your email address';
    } else if (!RegExp(emailRegex).hasMatch(val)) {
      isValidatedEmail(false);
      return 'The email you entered is invalid';
    } else {
      isValidatedEmail(true);
      return null;
    }
  }

  String? validatePassword(
    String? val,
  ) {
    if (val == null || val.isEmpty) {
      isValidatedPassword(false);
      return 'Please enter new password';
    } else if (val.length < 8) {
      isValidatedPassword(false);
      return 'Password must be of 8 characters';
    } else {
      isValidatedPassword(true);
      return null;
    }
  }
}
