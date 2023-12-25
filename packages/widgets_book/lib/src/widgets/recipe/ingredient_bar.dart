import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class IngredientBar extends StatelessWidget {
  const IngredientBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: AppColors.white),
      width: 786,
      child: Column(
        children: [
          12.verticalGap,
          Container(
            constraints: const BoxConstraints(
              maxWidth: 740,
            ),
            decoration: const BoxDecoration(
                color: AppColors.white,
                border: Border(
                    bottom:
                        BorderSide(width: 1.5, color: AppColors.whiteDada))),
            child: Flexible(
              flex: 1,
              child: Row(
                children: [
                  20.horizontalGap,
                  StandardText.headline1(
                    context,
                    'Ingredients',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack80,
                  ),
                  30.horizontalGap,
                  StandardText.headline1(
                    context,
                    'QTY',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack80,
                  ),
                  Spacer(),
                  StandardText.headline1(
                    context,
                    '\$',
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textBlack80,
                  ),
                  30.horizontalGap,
                ],
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 740,
            ),
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: Flexible(
              flex: 1,
              child: Row(
                children: [
                  20.horizontalGap,
                  StandardText.headline1(
                    context,
                    'Butter',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack80,
                  ),
                  38.horizontalGap,
                  StandardText.headline1(
                    context,
                    '50ts',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack80,
                  ),
                  const Spacer(),
                  StandardText.headline1(
                    context,
                    r'$7',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack80,
                  ),
                  30.horizontalGap,
                ],
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 740,
            ),
            decoration: const BoxDecoration(
              color: AppColors.lightGrey,
            ),
            child: Flexible(
              flex: 1,
              child: Row(
                children: [
                  20.horizontalGap,
                  StandardText.headline1(
                    context,
                    'All purpose flour',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack80,
                  ),
                  20.horizontalGap,
                  StandardText.headline1(
                    context,
                    '120g',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack80,
                  ),
                  const Spacer(),
                  StandardText.headline1(
                    context,
                    r'$10',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack80,
                  ),
                  30.horizontalGap,
                ],
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 740,
            ),
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: Flexible(
              flex: 1,
              child: Row(
                children: [
                  20.horizontalGap,
                  StandardText.headline1(
                    context,
                    'Chocolate Chips',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack80,
                  ),
                  21.horizontalGap,
                  StandardText.headline1(
                    context,
                    '50g',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack80,
                  ),
                  48.horizontalGap,
                  Flexible(
                    flex: 1,
                    child: StandardText.headline1(
                      context,
                      r'$3',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textBlack80,
                    ),
                  ),
                  5.horizontalGap,
                ],
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 740,
            ),
            decoration: const BoxDecoration(
              color: AppColors.lightGrey,
            ),
            child: Flexible(
              flex: 1,
              child: Row(
                children: [
                  20.horizontalGap,
                  StandardText.headline1(
                    context,
                    'Cinnamon',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack80,
                  ),
                  30.horizontalGap,
                  StandardText.headline1(
                    context,
                    '2tsp',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack80,
                  ),
                  const Spacer(),
                  StandardText.headline1(
                    context,
                    r'$0.6',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack80,
                  ),
                  30.horizontalGap,
                ],
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(
              maxWidth: 740,
            ),
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: Flexible(
              flex: 1,
              child: Row(
                children: [
                  20.horizontalGap,
                  StandardText.headline1(
                    context,
                    'Sugar',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack80,
                  ),
                  38.horizontalGap,
                  StandardText.headline1(
                    context,
                    '5tsp',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack80,
                  ),
                  const Spacer(),
                  StandardText.headline1(
                    context,
                    r'$1',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textBlack80,
                  ),
                  30.horizontalGap,
                ],
              ),
            ),
          ),
          12.verticalGap,
        ],
      ),
    );
  }
}
