// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:menumaster_manager/application/invite_chef/invite_chefs_bloc/invite_chefs_bloc.dart';
import 'package:menumaster_manager/infrastructure/signup/signup_repository.dart';
import 'package:meta/meta.dart';

part 'resend_invite_event.dart';
part 'resend_invite_state.dart';

class ResendInviteBloc extends Bloc<ResendInviteEvent, ResendInviteState> {
  final SignupRepository signupRepository;

  ResendInviteBloc({
    required this.signupRepository,
  }) : super(ResendInviteInitial()) {
    on<ResendInvite>(_onResendInvite);
  }

  Future<void> _onResendInvite(
    ResendInvite event,
    Emitter<ResendInviteState> emit,
  ) async {
    emit(SendingInvite());
    final response = await signupRepository.sendSignInLinkToEmail(
      email: event.email,
      actionCodeSettings: getActionCodeSettings(
          email: event.email,
          companyId: event.companyId,
          invitationID: event.invitationID),
    );
    return response.fold((l) => emit(ErrorSendingInvite(error: l.toString())),
        (r) => emit(ReInviteSent()));
  }
}
