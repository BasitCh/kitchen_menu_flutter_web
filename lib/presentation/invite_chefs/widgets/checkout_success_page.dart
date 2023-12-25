import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/invite_chef/invite_chefs_bloc/invite_chefs_bloc.dart';
import 'package:menumaster_manager/domain/services/cloud_firestore/i_cloud_firestore_repository.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/invite_chef/invite_repository.dart';
import 'package:menumaster_manager/infrastructure/invite_chef/payment_repository.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/infrastructure/services/shared_preferences_helper.dart';
import 'package:menumaster_manager/infrastructure/signup/signup_repository.dart';
import 'package:menumaster_manager/presentation/invite_chefs/widgets/checkout_success_dialog.dart';
import 'package:widgets_book/widgets_book.dart';

class CheckOutSuccessPage extends StatefulWidget {
  const CheckOutSuccessPage({super.key});

  @override
  State<CheckOutSuccessPage> createState() => _CheckOutSuccessPageState();
}

class _CheckOutSuccessPageState extends State<CheckOutSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InviteChefsBloc(
        signupRepository: RepositoryProvider.of<SignupRepository>(context),
        inviteRepository: InviteRepository(
          firestoreRepository: getIt<ICloudFirestoreRepository>(),
        ),
        paymentRepository: RepositoryProvider.of<PaymentRepository>(context),
      ),
      child: const CheckOutSuccessUI(),
    );
  }
}

class CheckOutSuccessUI extends StatefulWidget {
  const CheckOutSuccessUI({super.key});

  @override
  State<CheckOutSuccessUI> createState() => _CheckOutSuccessUIState();
}

class _CheckOutSuccessUIState extends State<CheckOutSuccessUI> {
  @override
  void initState() {
    super.initState();
    inviteChefs();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InviteChefsBloc, InviteChefsState>(
      listener: (context, state) {
        if (state is ErrorInviting) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: StandardText.headline1(
                  context,
                  state.error,
                  fontSize: 12,
                  color: AppColors.white,
                ),
              ),
            );
          getIt<NavigationService>().replaceWithNamed(
              context: context, uri: NavigationService.inviteChefsUri);
        } else if (state is ChefsInvited) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            showCheckoutSuccessDialog(context: context);
          });
          getIt<NavigationService>().replaceWithNamed(
              context: context, uri: NavigationService.dashBoardUri);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.accent,
                ),
                5.verticalGap,
                StandardText.headline3(context, 'Inviting Chefs'),
              ]),
        ),
      ),
    );
  }

  void inviteChefs() async {
    final chefs = await SharedPreferenceService.getChefsToBeInvited();
    if (!mounted) return;
    if (chefs != null && chefs.isNotEmpty) {
      this.context.read<InviteChefsBloc>().add(InviteChefs(chefs: chefs));
    }
  }
}
