import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class ListTileInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Assets.images.appLogoPng.image(height: 76, width: 76),
              12.horizontalSpace,
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      StandardText.headline1(
                        context,
                        'Jinu Abraham',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textBlack80,
                      ),
                      2.horizontalGap,
                      Container(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: 2,
                          bottom: 2,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.textfieldBorder,
                        ),
                        child: StandardText.headline1(
                          context,
                          'Inactive',
                          fontSize: 16,
                          color: AppColors.textBlack80,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  5.verticalGap,
                  StandardText.headline1(
                    context,
                    'Individual Chef   | Member Since 24/02/2022',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textBlack80,
                  ),
                  5.verticalGap,
                  StandardText.headline1(
                    context,
                    'A.D WORLD FOODS PTY LTD.',
                    fontFamily: Assets.fonts.yugothicLight,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: AppColors.textBlack80,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Assets.icons.icEye.svg(),
                  1.horizontalGap,
                  StandardText.headline1(
                    context,
                    'View Details',
                    fontFamily: Assets.fonts.yugothicLight,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.redDark,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
