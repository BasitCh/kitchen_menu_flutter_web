// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/invite_chef/add_remove_chef/add_remove_chef_bloc.dart';
import 'package:menumaster_manager/application/invite_chef/payment_bloc/payment_bloc.dart';
import 'package:menumaster_manager/domain/invite_chefs/invite.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/invite_chef/payment_repository.dart';
import 'package:menumaster_manager/infrastructure/services/shared_preferences_helper.dart';
import 'package:menumaster_manager/presentation/invite_chefs/widgets/item_invite.dart';
import 'package:menumaster_manager/presentation/widgets/app_bar.dart';
import 'package:widgets_book/widgets_book.dart';

class InviteChefsPage extends StatefulWidget {
  const InviteChefsPage({super.key});

  @override
  State<InviteChefsPage> createState() => _InviteChefsPageState();
}

class _InviteChefsPageState extends State<InviteChefsPage> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBar: const ManagerBar(),
        appBarHeight: 80,
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AddRemoveChefBloc()
                ..add(
                  AddChef(
                    chef: ItemInvite(),
                  ),
                ),
            ),
            BlocProvider<PaymentBloc>(
              create: (context) => PaymentBloc(
                  inviteRepository:
                      RepositoryProvider.of<PaymentRepository>(context)),
            ),
          ],
          child: const InviteChefUI(),
        ));
  }
}

class InviteChefUI extends StatefulWidget {
  const InviteChefUI({
    super.key,
  });

  @override
  State<InviteChefUI> createState() => _InviteChefUIState();
}

class _InviteChefUIState extends State<InviteChefUI> {
  final formKey = GlobalKey<FormState>();
  List<ItemInvite> chefs = [];

  @override
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is ErrorPayment) {
          getIt<Toasts>().showWebToast(
            context,
            width: context.width / 4,
            type: AlertType.Error,
            title: 'Alert!',
            description: state.error,
          );
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.verticalGap,
              StandardText.headline1(
                context,
                'Invite a chef',
                fontFamily: Assets.fonts.yugothicLight,
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: AppColors.textBlack80,
                align: TextAlign.start,
              ),
              5.verticalGap,
              StandardText.body2(context,
                  '''Invite one or more chefs to join your company.\nFill out the form below to send an invitation.''',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textBlack),
              30.verticalGap,
              Container(
                padding: const EdgeInsets.all(50),
                margin: EdgeInsets.only(right: context.width / 8),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(3, 2),
                    ),
                  ],
                ),
                child: BlocListener<AddRemoveChefBloc, AddRemoveChefState>(
                  listener: (context, state) {
                    if (state is ChefUpdated) {
                      chefs = state.chefs;
                    }
                  },
                  child: BlocBuilder<AddRemoveChefBloc, AddRemoveChefState>(
                    builder: (context, state) {
                      return Form(
                        key: formKey,
                        child: Column(
                          children: [
                            state is ChefUpdated
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.chefs.length,
                                    itemBuilder: (context, index) {
                                      return Stack(
                                        children: [
                                          Positioned(
                                            left: 0,
                                            child: StandardText.headline6(
                                              context,
                                              'Chef ${index + 1}',
                                              fontSize: 18,
                                            ),
                                          ),
                                          index + 1 > 1
                                              ? Positioned(
                                                  right: 0,
                                                  top: 4,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  AddRemoveChefBloc>(
                                                              context)
                                                          .add(RemoveChef(
                                                        index: index,
                                                      ));
                                                    },
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      color: AppColors.black,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          state.chefs[index],
                                        ],
                                      );
                                    },
                                  )
                                : const SizedBox.shrink(),
                            15.verticalGap,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: StandardText.headline5(
                                    context,
                                    'total amount: \$${(state is ChefUpdated ? state.chefs.length * 35 : 35)}',
                                    color: AppColors.accent,
                                    fontSize: 18,
                                    fontFamily: Assets.fonts.poppinsMedium,
                                    fontWeight: FontWeight.w700,
                                    align: TextAlign.start,
                                  ),
                                ),
                                const Spacer(),
                                Expanded(
                                  child: IgnorePointer(
                                    ignoring: state is AddingChef,
                                    child: AppButton.outlinedDarkBorder(
                                      radius: 5,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          BlocProvider.of<AddRemoveChefBloc>(
                                                  context)
                                              .add(AddChef(chef: ItemInvite()));
                                        }
                                      },
                                      child: StandardText.headline5(
                                        context,
                                        'ADD ANOTHER CHEF',
                                        color: AppColors.accent,
                                        fontSize: 18,
                                        fontFamily: Assets.fonts.poppinsMedium,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              50.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: kIsWeb ? context.width / 5 : context.width / 3,
                    margin: EdgeInsets.only(right: context.width / 8),
                    child: BlocBuilder<PaymentBloc, PaymentState>(
                      builder: (context, state) {
                        return (state is DoingPayment)
                            ? const AppButtonLoading()
                            : AppButton.darkRed(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    makePayment();
                                  }
                                },
                                radius: 8,
                                child: StandardText.buttonLarge(
                                  'SEND INVITE',
                                ),
                              );
                      },
                    ),
                  ),
                ],
              ),
              30.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  void makePayment() async {
    List<Invite> chefsToBeInvited = [];
    final appUser = await SharedPreferenceService.getUser();
    for (ItemInvite invite in chefs) {
      final inviteChef = Invite(
          email: invite.emailController.text.trim(),
          fullName: invite.nameController.text.trim(),
          companyId: appUser?.companyId ?? '',
          companyName: appUser?.companyName ?? '',
          subscriptionType: SubscriptionType.premium.name,
          subscriptionStatus: SubscriptionStatusEnum.Active.name,
          chefRole: ChefType.Company.name,
          userRole: UserType.Chef.name,
          createdAt: DateTime.now(),
          invitedBy: appUser?.id ?? '');
      chefsToBeInvited.add(inviteChef);
    }
    //saving the chefs to signleton which will be invited in success page
    await SharedPreferenceService.saveInvitedChefs(chefsToBeInvited);

    if (!mounted) return;
    this.context.read<PaymentBloc>().add(
          CreateStripePrice(price: '${35 * 100}'),
        );
    // getIt<NavigationService>().replaceWithNamed(
    //     context: this.context, uri: NavigationService.checkoutSuccessUri);
  }
}
