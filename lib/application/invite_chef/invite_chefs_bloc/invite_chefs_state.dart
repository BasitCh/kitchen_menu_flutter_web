part of 'invite_chefs_bloc.dart';

@immutable
sealed class InviteChefsState {}

final class InviteChefsInitial extends InviteChefsState {}

class InvitingChefs extends InviteChefsState {}

class ErrorInviting extends InviteChefsState {
  final String error;

  ErrorInviting({required this.error});
}

class ChefsInvited extends InviteChefsState {}

class EmailSent extends InviteChefsState {}
