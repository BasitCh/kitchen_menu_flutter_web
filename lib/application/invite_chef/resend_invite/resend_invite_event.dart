part of 'resend_invite_bloc.dart';

@immutable
sealed class ResendInviteEvent {}

class ResendInvite extends ResendInviteEvent {
  final String email;
  final String companyId;
  final String invitationID;

  ResendInvite(
      {required this.email,
      required this.companyId,
      required this.invitationID});
}
