import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class ProfileStepper extends StatelessWidget {
  const ProfileStepper({super.key, required this.currentStep});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StandardText.headline5(context, 'Step $currentStep/2'),
        6.verticalGap,
        Row(
          children: [
            Container(
              width: context.width / 10,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            2.horizontalGap,
            Container(
              width: context.width / 10,
              height: 5,
              decoration: BoxDecoration(
                color: currentStep == 1 ? AppColors.gray :  AppColors.accent,
                borderRadius: BorderRadius.circular(20),
              ),
            )
          ],
        )
      ],
    );
  }
}
