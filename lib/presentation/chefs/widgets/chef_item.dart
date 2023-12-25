import 'package:flutter/material.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/presentation/chefs/widgets/delete_user_dialog.dart';
import 'package:menumaster_manager/presentation/chefs/widgets/pending_invitation_dialog.dart';
import 'package:menumaster_manager/presentation/chefs/widgets/subscription_status.dart';
import 'package:widgets_book/widgets_book.dart';

class ChefItem extends StatelessWidget {
  const ChefItem({super.key, required this.user, this.showDeleteIcon = true});

  final AppUser user;
  final bool? showDeleteIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          user.imageUrl != null
              ? AvatarView(
                  radius: 50,
                  borderColor: Colors.transparent,
                  isOnlyText: false,
                  avatarType: AvatarType.CIRCLE,
                  backgroundColor: Colors.transparent,
                  imagePath: user.imageUrl ?? '',
                  placeHolder: Container(
                    child: Assets.images.noImagePlaceholder
                        .image(fit: BoxFit.contain),
                  ),
                  errorWidget: Container(
                    child: Assets.images.noImagePlaceholder
                        .image(fit: BoxFit.contain),
                  ),
                )
              : Assets.images.noImagePlaceholder.image(height: 100, width: 100),
          8.horizontalSpace,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: StandardText.body2(
                        context,
                        user.fullName ?? '',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textBlack80,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    2.horizontalGap,
                    SubscriptionStatus(
                      status: user.invitedBy == null ? 'Active' : 'Pending',
                      bgColor: user.invitedBy == null
                          ? AppColors.greenDark
                          : const Color(0xFFD87B2E),
                      textColor: AppColors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 3),
                    )
                  ],
                ),
                5.verticalGap,
                StandardText.headline1(
                  context,
                  user.invitedBy == null
                      ? 'Registered by company ${user.createdAt != null ? '| Member Since ${DateFormat('dd/MM/yyyy').format(user.createdAt!)}' : ''}'
                      : 'Invitation sent ${user.createdAt != null ? ' ${DateFormat('dd/MM/yyyy').format(user.createdAt!)}' : ''} | Invitation not accepted yet',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textBlack80,
                ),
                5.verticalGap,
                user.invitedBy == null
                    ? StandardText.headline1(
                        context,
                        'Revolving Menu Plan shared by "${user.fullName ?? ''}"',
                        fontFamily: Assets.fonts.yugothicLight,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: AppColors.accent,
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.visibility_rounded,
                  color: AppColors.black,
                  size: 23,
                ),
                onPressed: () {
                  if (user.invitedBy == null) {
                    getIt<NavigationService>().navigateToNamed(
                        context: context,
                        uri: NavigationService.mealPlansUri,
                        data: user.id);
                  } else {
                    showPendingInvitationDialog(context: context, user: user);
                  }
                },
              ),
              3.horizontalGap,
              !showDeleteIcon!
                  ? const SizedBox.shrink()
                  : IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: AppColors.black,
                      ),
                      onPressed: () {
                        showdeleteUserDialog(context: context, user: user);
                      },
                    )
            ],
          ),
        ],
      ),
    );
  }
}
