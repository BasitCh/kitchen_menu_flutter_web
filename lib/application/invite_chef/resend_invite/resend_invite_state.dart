part of 'resend_invite_bloc.dart';

@immutable
sealed class ResendInviteState {}

final class ResendInviteInitial extends ResendInviteState {}

class SendingInvite extends ResendInviteState {}

class ReInviteSent extends ResendInviteState {}

class ErrorSendingInvite extends ResendInviteState {
  final String error;
  ErrorSendingInvite({required this.error});
}
