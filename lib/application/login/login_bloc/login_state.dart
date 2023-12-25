part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoggingIn extends LoginState {}

class LoggedIn extends LoginState {}

class LoginError extends LoginState {
  LoginError({
    required this.message,
  });

  final String message;
}

class UserProfileMissing extends LoginState {}

class CompanyProfileMissing extends LoginState {}

class LoadingUser extends LoginState {}

class UserLoaded extends LoginState {
  final AppUser user;

  UserLoaded({required this.user});
}

class ErrorLoadingUser extends LoginState {
  final String error;

  ErrorLoadingUser({
    required this.error,
  });
}
