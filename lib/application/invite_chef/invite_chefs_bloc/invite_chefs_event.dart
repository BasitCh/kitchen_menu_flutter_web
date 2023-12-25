part of 'invite_chefs_bloc.dart';

@immutable
sealed class InviteChefsEvent {}

class InviteChefs extends InviteChefsEvent {
  final List<Invite> chefs;

  InviteChefs({required this.chefs});
}
