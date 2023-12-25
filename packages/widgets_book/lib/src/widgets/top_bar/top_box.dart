import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        10.verticalGap,
        Container(
          margin: EdgeInsets.only(right: 30.0),
          child: StandardText.headline1(
            context,
            'Welcome',
            fontFamily: FontFamily.yugothic,
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
            color: AppColors.textBlack80,
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 30.0),
          child: StandardText.headline1(
            context,
            'Super Admin',
            fontFamily: FontFamily.yugothic,
            fontWeight: FontWeight.w300,
            fontSize: 24,
            color: AppColors.textBlack80,
          ),
        ),
        5.verticalSpace,
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.black25,
                spreadRadius: 0.2,
                blurRadius: 0.2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Container()
        )
      ],
    );
  }
}
