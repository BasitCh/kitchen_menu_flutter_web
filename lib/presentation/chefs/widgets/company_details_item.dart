import 'package:flutter/material.dart';
import 'package:menumaster_manager/domain/profile/company.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/presentation/chefs/widgets/subscription_status.dart';
import 'package:widgets_book/widgets_book.dart';

class CompanyDetailsItem extends StatelessWidget {
  const CompanyDetailsItem({
    super.key,
    required this.company,
    required this.chefsLenth,
  });

  final Company company;
  final int chefsLenth;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              flex: 6,
              child: StandardText.headline1(
                context,
                company.companyName ?? '',
                fontFamily: Assets.fonts.yugothicLight,
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: AppColors.textBlack80,
                align: TextAlign.start,
              ),
            ),
            8.horizontalGap,
            const SubscriptionStatus(
              status: 'Active Subscription',
              bgColor: AppColors.greenDark,
              textColor: AppColors.white,
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            ),
            4.horizontalGap,
          ],
        ),
        35.verticalGap,
        Row(
          children: [
            Flexible(
              flex: 4,
              child: company.companyLogo != null
                  ? AvatarView(
                      radius: 60,
                      borderColor: Colors.transparent,
                      isOnlyText: false,
                      avatarType: AvatarType.CIRCLE,
                      backgroundColor: Colors.transparent,
                      imagePath: company.companyLogo ?? '',
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
                children: [
                  StandardText.headline1(
                    context,
                    'Yearly subscription: \$${35 * chefsLenth} / Month',
                    fontSize: 22,
                    color: AppColors.greenDark,
                    fontWeight: FontWeight.w900,
                    fontFamily: Assets.fonts.poppinsBold,
                  ),
                  25.verticalGap,
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: StandardText.headline1(
                          context,
                          'Phone:',
                          fontSize: 22,
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
                          company.phoneNumber ?? '',
                          fontSize: 22,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          align: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  2.verticalGap,
                  Row(
                    children: [
                      Flexible(
                        flex: 3,
                        child: StandardText.headline1(
                          context,
                          'Email:',
                          fontSize: 22,
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
                          firebaseAuth.currentUser?.email ?? '',
                          fontSize: 22,
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
                          fontSize: 22,
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
                          company.address?.streetAddress ??
                              company.address?.countryName ??
                              '',
                          fontSize: 22,
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
        50.verticalGap,
        Container(
          margin: EdgeInsets.only(right: context.width / 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.hoverColor,
                      border: Border.all(color: AppColors.accent)),
                  child: Column(
                    children: [
                      StandardText.headline1(
                        context,
                        'Total Chefs',
                        fontSize: 18,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w500,
                      ),
                      12.verticalGap,
                      StandardText.body2(
                        context,
                        '$chefsLenth',
                        fontSize: 18,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w700,
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
              ),
              10.horizontalGap,
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.hoverColor,
                      border: Border.all(color: AppColors.accent)),
                  child: Column(
                    children: [
                      StandardText.headline1(
                        context,
                        'Cost/Chef',
                        fontSize: 18,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w500,
                      ),
                      12.verticalGap,
                      StandardText.body2(
                        context,
                        '${'\$'}35',
                        fontSize: 18,
                        color: AppColors.accent,
                        fontWeight: FontWeight.w700,
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
