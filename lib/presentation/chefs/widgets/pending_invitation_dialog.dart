import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/invite_chef/resend_invite/resend_invite_bloc.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:widgets_book/widgets_book.dart';

Future<Object> showPendingInvitationDialog(
    {required BuildContext context, required AppUser user}) async {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return Center(
        child: Container(
          width: 700,
          height: 580,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Scaffold(
            backgroundColor: AppColors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          getIt<NavigationService>()
                              .navigateBack(context: context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.black,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        50.verticalGap,
                        Assets.icons.pendingInvitationIcon.svg(),
                        30.verticalGap,
                        StandardText.headline6(
                          context,
                          'Invitation not accepted yet',
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                        30.verticalGap,
                        RichText(
                          text: TextSpan(
                            style: UITextStyle.subtitle3.copyWith(fontSize: 15),
                            children: <TextSpan>[
                              const TextSpan(
                                text: 'Invite sent on ',
                              ),
                              TextSpan(
                                  text: DateFormat('dd-MM-yyyy')
                                      .format(user.createdAt!),
                                  style: UITextStyle.subtitle3.copyWith(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        5.verticalGap,
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: UITextStyle.subtitle3.copyWith(
                                fontSize: 13, color: AppColors.textBlack60),
                            children: const <TextSpan>[
                              TextSpan(
                                text:
                                    'You have already sent an invite to this chef, But chef has not accepted the invite yet',
                              ),
                            ],
                          ),
                        ),
                        40.verticalGap,
                        BlocConsumer<ResendInviteBloc, ResendInviteState>(
                          listener: (blocContext, state) {
                            if (state is ReInviteSent) {
                              getIt<NavigationService>()
                                  .navigateBack(context: context);
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                getIt<Toasts>().showWebToast(
                                  context,
                                  width: context.width / 4,
                                  type: AlertType.Success,
                                  title: 'Success',
                                  prefixWidget: const Icon(
                                    Icons.check,
                                    color: AppColors.greenDark,
                                  ),
                                  description: 'The invite has been resent!',
                                );
                              });
                            } else if (state is ErrorSendingInvite) {
                              getIt<NavigationService>()
                                  .navigateBack(context: context);

                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                getIt<Toasts>().showWebToast(
                                  context,
                                  width: context.width / 4,
                                  prefixWidget: const Icon(
                                    Icons.cancel,
                                    color: AppColors.accent,
                                  ),
                                  type: AlertType.Error,
                                  title: 'Error',
                                  description: state.error,
                                );
                              });
                            }
                          },
                          builder: (context, state) {
                            return SizedBox(
                              width: kIsWeb
                                  ? context.width / 5
                                  : context.width / 3,
                              child: state is SendingInvite
                                  ? const AppButtonLoading()
                                  : AppButton.outlinedDarkBorder(
                                      onPressed: () {
                                        context.read<ResendInviteBloc>().add(
                                              ResendInvite(
                                                  email: user.email ?? '',
                                                  companyId:
                                                      user.companyId ?? '',
                                                  invitationID:
                                                      user.invitationId ?? ''),
                                            );
                                      },
                                      radius: 8,
                                      child: StandardText.buttonLarge(
                                        'RESEND INVITE',
                                        color: AppColors.accent,
                                      ),
                                    ),
                            );
                          },
                        ),
                        8.verticalGap,
                        SizedBox(
                          width: kIsWeb ? context.width / 5 : context.width / 3,
                          child: AppButton.darkRed(
                            onPressed: () {
                              getIt<NavigationService>()
                                  .navigateBack(context: context);
                            },
                            radius: 8,
                            child: StandardText.buttonLarge(
                              'CLOSE',
                            ),
                          ),
                        ),
                        5.verticalGap,
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
