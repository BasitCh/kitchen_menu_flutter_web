import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppliedCategoryCard extends StatelessWidget {
  const AppliedCategoryCard({
    required this.children,
    super.key,
    this.backgroundColor,
    this.padding,
    this.width,
    this.elevation,
    this.isReviewRecipe = false,
    this.onClearFilters,
  });

  final List<Widget> children;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final double? width;
  final double? elevation;
  final bool isReviewRecipe;
  final VoidCallback? onClearFilters;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? context.width - 40,
      padding:
          padding ?? EdgeInsets.symmetric(vertical: 28.h, horizontal: 20.h),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(12),
      //   color: backgroundColor ?? AppColors.white,
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Spacer(),
          //     Visibility(
          //       visible: !isReviewRecipe,
          //       child: InkWell(
          //         onTap: () {
          //           if (onClearFilters != null) {
          //             onClearFilters!();
          //           } else {
          //             // context.read<RecipesAppliedFiltersCubit>().reset();
          //             // context.read<RecipesFilterCubit>().reset();
          //           }
          //         },
          //         child: kIsWeb
          //             ? context
          //                     .read<RecipesAppliedFiltersCubit>()
          //                     .state
          //                     .isNotEmpty
          //                 ? Row(
          //                     children: [
          //                       StandardText.headline1(
          //                         context,
          //                         AppLocalizations.of(context)!
          //                             .all_recipes_clear_filters,
          //                         color: AppColors.accent,
          //                         fontWeight: FontWeight.w500,
          //                         fontSize: 18.sp,
          //                       ),
          //                       Assets.icons.icClear.svg(),
          //                     ],
          //                   )
          //                 : Container()
          //             : Row(
          //                 children: [
          //                   StandardText.subtitle2(
          //                     context,
          //                     AppLocalizations.of(context)!
          //                         .all_recipes_clear_filters,
          //                     color: AppColors.accent,
          //                   ),
          //                   const Icon(
          //                     Icons.close,
          //                     color: AppColors.accent,
          //                     size: 17,
          //                   ),
          //                 ],
          //               ),
          //       ),
          //     ),
          //     12.horizontalSpace,
          //   ],
          // ),
          // 10.verticalSpace,
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: children,
          ),
        ],
      ),
    );
  }
}
