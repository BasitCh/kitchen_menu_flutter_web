part of 'forgot_passsword_bloc.dart';

@immutable
sealed class ForgotPassswordEvent {}

class SendPasswordResetEmail extends ForgotPassswordEvent {
  final String email;

  SendPasswordResetEmail({required this.email});
}
