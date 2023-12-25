import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class ReviewRecipePrepSteps extends StatelessWidget {
  const ReviewRecipePrepSteps({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StandardText.headline5(
          context,
          AppLocalizations.of(context)!.create_recipe_prep_steps,
          fontSize: 18.sp,
          fontWeight: AppFontWeight.bold,
        ),
        10.verticalSpace,
        StandardText.subtitle3(
          context,
          AppLocalizations.of(context)!.review_recipe_preparation_step,
          fontSize: 12.sp,
          letterSpacing: 0.8,
        ),
        PreparationSteps(
          createPrepStepCubits: context.read<CreatePrepStepCubits>(),
          isReviewRecipe: true,
        ),
        30.verticalSpace,
      ],
    );
  }
}