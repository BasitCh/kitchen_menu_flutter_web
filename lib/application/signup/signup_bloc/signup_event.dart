part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignUp extends SignupEvent {
  final String email, password;
  SignUp({
    required this.email,
    required this.password,
  });
}

class SaveUser extends SignupEvent {
  final String email;

  SaveUser({required this.email});
}

class SendEmailVerification extends SignupEvent {
  final AppUser user;
  SendEmailVerification({required this.user});
}
