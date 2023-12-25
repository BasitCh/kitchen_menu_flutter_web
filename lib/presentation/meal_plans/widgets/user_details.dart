import 'package:flutter/material.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:widgets_book/widgets_book.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key, required this.user});

  final AppUser user;

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
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
                widget.user.fullName ?? '',
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
              child: widget.user.imageUrl != null
                  ? AvatarView(
                      radius: 60,
                      borderColor: Colors.transparent,
                      isOnlyText: false,
                      avatarType: AvatarType.CIRCLE,
                      backgroundColor: Colors.transparent,
                      imagePath: widget.user.imageUrl ?? '',
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
                  StandardText.headline1(
                    context,
                    'Monthly subscription: \$35 / Month',
                    fontSize: 20,
                    color: AppColors.accent,
                    fontWeight: FontWeight.w900,
                    fontFamily: Assets.fonts.poppinsBold,
                  ),
                  25.verticalGap,
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
                          '${widget.user.address?.countryName == 'New Zealand' ? '+64' : '+61'}${widget.user.phoneNumber}',
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
                          widget.user.email ?? '',
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
                          widget.user.address?.streetAddress ??
                              widget.user.address?.countryName ??
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
      ],
    );
  }
}
