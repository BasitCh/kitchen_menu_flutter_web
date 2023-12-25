part of 'forgot_passsword_bloc.dart';

@immutable
sealed class ForgotPassswordState {}

final class ForgotPassswordInitial extends ForgotPassswordState {}

class SendingEmail extends ForgotPassswordState {}

class PasswordSent extends ForgotPassswordState {}

class ErrorSendingEmail extends ForgotPassswordState {
  final String error;

  ErrorSendingEmail({required this.error});
}
