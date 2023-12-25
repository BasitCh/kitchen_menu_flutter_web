// ignore_for_file: always_specify_types, lines_longer_than_80_chars

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({
    super.key,
    this.isWeb = false,
  });

  final bool? isWeb;

  @override
  Widget build(BuildContext context) {
    return kIsWeb?
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Assets.icons.noInternet.svg(
            width: 72.h,
            height: 72.h,
            fit: BoxFit.scaleDown,
          ),
          44.verticalGap,
          StandardText.headline3(
            context,
            AppLocalizations.of(context)!.common_no_internet.toUpperCase(),
            color: AppColors.textBlack80,
          ),
          12.verticalGap,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 26.h),
            child: StandardText.subtitle2(
              context,
              AppLocalizations.of(context)!.common_no_internet_description,
              fontSize: 14.sp,
              align: TextAlign.center,
              color: AppColors.textBlack50,
              height: 1.71,
              letterSpacing: -0.40,
            ),
          ),
          70.verticalSpace,
          SizedBox(
            width: context.width/2,
            child: AppButton.darkRed(
              onPressed: (){
                print('trying again');
              },
              child: StandardText.buttonLarge(
                AppLocalizations.of(context)!.common_try_again,
              ),
            ),
          ),
        ],
      ),
    )
        :

      Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Assets.icons.noInternet.svg(
              width: 72.h,
              height: 72.h,
              fit: BoxFit.scaleDown,
            ),
            44.verticalGap,
            StandardText.headline3(
              context,
              AppLocalizations.of(context)!.common_no_internet.toUpperCase(),
              color: AppColors.textBlack80,
            ),
            12.verticalGap,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 26.h),
              child: StandardText.subtitle2(
                context,
                AppLocalizations.of(context)!.common_no_internet_description,
                fontSize: 14.sp,
                align: TextAlign.center,
                color: AppColors.textBlack50,
                height: 1.71,
                letterSpacing: -0.40,
              ),
            ),
            70.verticalSpace,
            if (isWeb!)
              SizedBox(
                width: kIsWeb ? context.width / 4 : context.width * 3,
                child: AppButton.darkRed(
                  onPressed: () {},
                  child: StandardText.buttonLarge(
                    AppLocalizations.of(context)!.common_try_again,
                  ),
                ),
              )
            else
              AppButton.darkRed(
                onPressed: () {},
                child: StandardText.buttonLarge(
                  AppLocalizations.of(context)!.common_try_again,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
