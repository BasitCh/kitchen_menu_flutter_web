import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/chefs/chefs_bloc/chefs_bloc.dart';
import 'package:menumaster_manager/application/chefs/remove_chef_bloc/remove_chef_bloc.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:widgets_book/widgets_book.dart';

Future<Object> showdeleteUserDialog(
    {required BuildContext context, required AppUser user}) async {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return BlocConsumer<RemoveChefBloc, RemoveChefState>(
        listener: (context, state) {
          if (state is ErrorRemovingChef) {
            Navigator.of(context).pop();
            // err dialog
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
          } else if (state is ChefRemoved) {
            Navigator.of(context).pop();
            context.read<ChefsBloc>().add(GetCompany());
          }
        },
        builder: (context, state) {
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
                            onPressed: state is RemovingChef
                                ? null
                                : () {
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
                            Assets.icons.deleteAlert.svg(),
                            30.verticalGap,
                            StandardText.headline6(
                              context,
                              'Remove ${user.fullName}?',
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                            ),
                            30.verticalGap,
                            RichText(
                              text: TextSpan(
                                style: UITextStyle.subtitle3
                                    .copyWith(fontSize: 15),
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Member Since ',
                                  ),
                                  TextSpan(
                                      text: DateFormat('dd-MM-yyyy')
                                          .format(user.createdAt!),
                                      style: UITextStyle.subtitle3.copyWith(
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            5.verticalGap,
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: UITextStyle.subtitle3
                                    .copyWith(fontSize: 15),
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Are you sure you want to remove',
                                  ),
                                  TextSpan(
                                    text: ' ${user.fullName} ',
                                    style: UITextStyle.subtitle3.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const TextSpan(
                                    text:
                                        'from company and unsubscribe the payment plan?',
                                  ),
                                ],
                              ),
                            ),
                            40.verticalGap,
                            SizedBox(
                              width: kIsWeb
                                  ? context.width / 5
                                  : context.width / 3,
                              child: AppButton.outlinedDarkBorder(
                                onPressed: state is RemovingChef
                                    ? null
                                    : () {
                                        Navigator.of(context).pop();
                                      },
                                radius: 8,
                                child: StandardText.buttonLarge(
                                  'GO BACK',
                                  color: AppColors.accent,
                                ),
                              ),
                            ),
                            5.verticalGap,
                            SizedBox(
                              width: kIsWeb
                                  ? context.width / 5
                                  : context.width / 3,
                              child: state is RemovingChef
                                  ? const AppButtonLoading()
                                  : AppButton.darkRed(
                                      onPressed: () {
                                        context.read<RemoveChefBloc>().add(
                                              RemoveChef(user: user),
                                            );
                                      },
                                      radius: 8,
                                      child: StandardText.buttonLarge(
                                        'YES, REMOVE IT',
                                      ),
                                    ),
                            ),
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
    },
  );
}
