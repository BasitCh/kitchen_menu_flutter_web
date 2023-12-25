// ignore_for_file: depend_on_referenced_packages

import 'package:fpdart/fpdart.dart';
import 'package:menumaster_manager/domain/invite_chefs/invite.dart';
import 'package:menumaster_manager/infrastructure/invite_chef/invite_repository.dart';
import 'package:menumaster_manager/infrastructure/invite_chef/payment_repository.dart';
import 'package:menumaster_manager/infrastructure/signup/signup_repository.dart';
import 'package:meta/meta.dart';
import 'package:widgets_book/widgets_book.dart';

part 'invite_chefs_event.dart';
part 'invite_chefs_state.dart';

class InviteChefsBloc extends Bloc<InviteChefsEvent, InviteChefsState> {
  final InviteRepository inviteRepository;
  final SignupRepository signupRepository;
  final PaymentRepository paymentRepository;

  InviteChefsBloc({
    required this.inviteRepository,
    required this.signupRepository,
    required this.paymentRepository,
  }) : super(InviteChefsInitial()) {
    on<InviteChefs>(_onInviteChefs);
  }

  Future<void> _onInviteChefs(
    InviteChefs event,
    Emitter<InviteChefsState> emit,
  ) async {
    emit(InvitingChefs());
    try {
      final subscriptionResponse =
          await paymentRepository.getAllSupscriptions();
      final subscriptions = subscriptionResponse.getRight().toNullable();
      for (Invite invite in event.chefs) {
        String subscriptionId = '';
        if (subscriptions?.data != null && subscriptions!.data!.isNotEmpty) {
          subscriptionId = subscriptions.data!
              .where((element) => element.items!.data!.any((element) =>
                  element.price?.product == invite.stripeProductId))
              .first
              .id!;
        }

        // updating the object to store created subscription id
        invite.subscriptionId = subscriptionId;
        final invitationResponse = await inviteRepository.inviteCompanyChef(
            companyId: invite.companyId ?? '', invite: invite);

        invitationResponse
            .fold((l) => emit(ErrorInviting(error: l.message.toString())),
                (invitationID) async {
          final emailResponse = await sendEmail(
              email: invite.email ?? '',
              companyId: invite.companyId ?? '',
              invitationID: invitationID);
          emailResponse.fold((l) {
            if (emit.isDone) {
              emit(ErrorInviting(error: l.message.toString()));
            }
          }, (r) {});
        });
      }

      emit(ChefsInvited());
    } catch (e) {
      emit(
        ErrorInviting(
          error: e.toString(),
        ),
      );
    }
  }

  Future<Either<ApiError, Unit>> sendEmail(
      {required String email,
      required String companyId,
      required String invitationID}) async {
    final response = await signupRepository.sendSignInLinkToEmail(
      email: email,
      actionCodeSettings: getActionCodeSettings(
          email: email, companyId: companyId, invitationID: invitationID),
    );
    return response.fold((l) => left(l), (r) => right(r));
  }
}

ActionCodeSettings getActionCodeSettings(
    {required String email,
    required String companyId,
    required String invitationID}) {
  return ActionCodeSettings(
      url:
          'https://menumasterprod.page.link/m5Xz?email=$email&company_id=$companyId&invitation_id=$invitationID',
      dynamicLinkDomain: 'menumasterprod.page.link',
      handleCodeInApp: true,
      iOSBundleId: 'com.menu.master',
      androidPackageName: 'com.menu.master',
      androidInstallApp: true);
}
