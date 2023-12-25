import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class DashBoardItem extends StatelessWidget {
  const DashBoardItem(
      {required this.icon,
      required this.title,
      required this.description,
      required this.onClick,
      super.key});

  final Widget icon;
  final String title, description;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            5.verticalGap,
            StandardText.headline1(
              context,
              title,
              fontFamily: Assets.fonts.poppinsBold,
              fontWeight: FontWeight.w700,
              align: TextAlign.center,
              fontSize: 26,
              color: AppColors.accent,
            ),
            5.verticalGap,
            StandardText.body2(
              context,
              description,
              fontWeight: FontWeight.w400,
              align: TextAlign.center,
              fontSize: 16,
            )
          ],
        ),
      ),
    );
  }
}
