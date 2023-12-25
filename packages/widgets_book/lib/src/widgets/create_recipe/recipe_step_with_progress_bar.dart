import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../colors/app_colors.dart';
import '../../localization/l10n/gen/app_localizations.dart';
import '../../typography/app_font_weight.dart';
import '../widgets.dart';

class RecipeStepWithProgressBar extends StatelessWidget {
  const RecipeStepWithProgressBar({
    required this.title,
    required this.stepNo,
    required this.barValue,
    this.subtitle,
    this.isUserApp=false,
    super.key,
  });

  final String title;
  final int stepNo;
  final double barValue;
  final String? subtitle;
  final bool isUserApp;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            StandardText.headline5(
              context,
              '$title  ',
              fontSize: 20,
              fontWeight: AppFontWeight.bold,
            ),
            if (stepNo == 1)
              StandardText.subtitle2(
                context,
                AppLocalizations.of(context)!.create_recipe_step_1_4,
              )
            else
              stepNo == 2
                  ? StandardText.subtitle2(
                      context,
                      AppLocalizations.of(context)!.create_recipe_step_2_4,
                    )
                  : stepNo == 3
                      ? StandardText.subtitle2(
                          context,
                          AppLocalizations.of(context)!.create_recipe_step_3_4,
                        )
                      : stepNo == 4
                          ? StandardText.subtitle2(
                              context,
                              AppLocalizations.of(context)!
                                  .create_recipe_step_4_4,
                            )
                          : StandardText.subtitle2(
                              context,
                              subtitle ?? '',
                            ),
          ],
        ),
        4.verticalSpace,
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: LinearProgressIndicator(
            minHeight: isUserApp?5:10.0708,
            value: barValue,
            color: AppColors.seaGreen,
            backgroundColor: AppColors.grey400.withOpacity(.3),
          ),
        ),
        30.verticalSpace,
      ],
    );
  }
}
