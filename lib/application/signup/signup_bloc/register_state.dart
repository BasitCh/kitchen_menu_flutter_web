part of 'signup_bloc.dart';

@immutable
sealed class RegisterState {}

final class SignupInitial extends RegisterState {}

class SigningUp extends RegisterState {}

class ErrorSigningup extends RegisterState {
  final String error;
  ErrorSigningup({required this.error});
}

class Signedup extends RegisterState {
  final AppUser user;

  Signedup({required this.user});
}
