import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:widgets_book/widgets_book.dart';

class StepIndicator extends StatelessWidget {
  const StepIndicator({required this.mainHeading, required this.stepCount,
    required this.currentStep, super.key,});
  final String mainHeading;
  final String stepCount;
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            StandardText.headline1(
              context,
              mainHeading,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.textBlack80,
            ),
            StandardText.headline1(
              context,
              stepCount,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppColors.textBlack80,
            ),
          ],
        ),
        12.verticalGap,
        SizedBox(
          width: context.width/2,
          child: StepProgressIndicator(
            totalSteps: 4,
            currentStep: currentStep,
            size: 6,
            selectedColor: AppColors.seaGreen,
            padding: 0.5,
            unselectedColor: AppColors.stepGrey.withOpacity(0.2),
            roundedEdges: const Radius.circular(8),
          ),
        ),
      ],
    );
  }
}
