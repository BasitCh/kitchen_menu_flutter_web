part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class Login extends LoginEvent {
  Login({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

class CheckUserVerification extends LoginEvent {
  final User user;

  CheckUserVerification({
    required this.user,
  });
}

class CheckProfileUpdated extends LoginEvent {}

class GetUserById extends LoginEvent {
  final String userId;

  GetUserById({
    required this.userId,
  });
}
