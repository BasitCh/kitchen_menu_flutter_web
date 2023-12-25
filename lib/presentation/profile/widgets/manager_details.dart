import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:widgets_book/widgets_book.dart';

class ManagerDetails extends StatelessWidget {
  const ManagerDetails({super.key, required this.user});
  final AppUser user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        30.verticalGap,
        Row(
          children: [
            Flexible(
              flex: 6,
              child: StandardText.headline1(
                context,
                user.fullName ?? '',
                fontFamily: Assets.fonts.yugothicLight,
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: AppColors.textBlack80,
                align: TextAlign.start,
              ),
            ),
          ],
        ),
        35.verticalGap,
        Row(
          children: [
            Flexible(
              flex: 4,
              child: user.imageUrl != null
                  ? AvatarView(
                      radius: 60,
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
                  : Assets.images.noImagePlaceholder
                      .image(height: 120, width: 120),
            ),
            10.horizontalGap,
            Flexible(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        child: StandardText.headline1(
                          context,
                          'Phone:',
                          fontSize: 18,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: Assets.fonts.poppinsBold,
                        ),
                      ),
                      1.horizontalGap,
                      Flexible(
                        flex: 7,
                        child: StandardText.headline1(
                          context,
                          '${user.address?.countryName == 'New Zealand' ? '+64' : '+61'}${user.phoneNumber}',
                          fontSize: 18,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          align: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  2.verticalGap,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        child: StandardText.headline1(
                          context,
                          'Email:',
                          fontSize: 18,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: Assets.fonts.poppinsBold,
                        ),
                      ),
                      1.horizontalGap,
                      Flexible(
                        flex: 7,
                        child: StandardText.headline1(
                          context,
                          user.email ?? '',
                          fontSize: 18,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          align: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  2.verticalGap,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 3,
                        child: StandardText.headline1(
                          context,
                          'Address:',
                          fontSize: 18,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontFamily: Assets.fonts.poppinsBold,
                        ),
                      ),
                      1.horizontalGap,
                      Flexible(
                        flex: 7,
                        child: StandardText.headline1(
                          context,
                          user.address?.streetAddress ??
                              user.address?.countryName ??
                              '',
                          fontSize: 18,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          align: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        20.verticalGap,
        SizedBox(
          width: kIsWeb ? context.width / 5 : context.width / 3,
          child: AppButton.darkRed(
            onPressed: () {
              getIt<NavigationService>().navigateToNamed(
                context: context,
                uri: NavigationService.setupProfileUri,
                data: user,
              );
            },
            radius: 8,
            child: StandardText.buttonLarge(
              'EDIT PERSONAL INFO',
            ),
          ),
        ),
      ],
    );
  }
}
