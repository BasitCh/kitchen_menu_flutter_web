import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class IngredientsTableHeader extends StatelessWidget {
  const IngredientsTableHeader({
    required this.isReviewRecipe,
    this.isManager = false,
    super.key,
  });
  final bool isReviewRecipe;
  final bool? isManager;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 20.h, bottom: 10.h, left: 20.h, right: 20.h),
      child: Row(
        children: [
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: kIsWeb
                ? StandardText.subtitle3(
                    context,
                    AppLocalizations.of(context)!
                        .create_recipe_ingredients
                        .toLowerCase()
                        .toTitleCase(),
                    fontSize: isManager! ? 16.sp : 22.sp,
                    fontWeight: AppFontWeight.semiBold,
                  )
                : StandardText.subtitle3(
                    context,
                    AppLocalizations.of(context)!
                        .create_recipe_ingredients
                        .toLowerCase()
                        .toTitleCase(),
                    fontWeight: AppFontWeight.semiBold,
                  ),
          ),
          Flexible(
            flex: 5,
            fit: FlexFit.tight,
            child: kIsWeb
                ? StandardText.subtitle3(
                    context,
                    AppLocalizations.of(context)!.create_recipe_qty,
                    fontWeight: AppFontWeight.semiBold,
                    fontSize: isManager! ? 16.sp : 22.sp,
                  )
                : StandardText.subtitle3(
                    context,
                    AppLocalizations.of(context)!.create_recipe_qty,
                    fontWeight: AppFontWeight.semiBold,
                  ),
          ),
          // Flexible(
          //   flex: 2,
          //   fit: FlexFit.tight,
          //   child: kIsWeb
          //       ? StandardText.subtitle3(
          //           context,
          //           AppLocalizations.of(context)!.create_recipe_nzd,
          //           fontWeight: AppFontWeight.semiBold,
          //           fontSize: isManager! ? 16.sp : 22.sp,
          //         )
          //       : StandardText.subtitle3(
          //           context,
          //           AppLocalizations.of(context)!.create_recipe_nzd,
          //           fontWeight: AppFontWeight.semiBold,
          //         ),
          // ),
          Visibility(
            visible: !isReviewRecipe,
            child: Flexible(
              child: StandardText.subtitle3(
                context,
                '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
