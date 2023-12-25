import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppliedCategoryItem extends StatelessWidget {
  const AppliedCategoryItem({
    required this.title,
    super.key,
    this.onTapClose,
  });

  final String title;
  final VoidCallback? onTapClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      margin: const EdgeInsets.only(
        right: 4,
        top: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border:Border.all(color: AppColors.charcoal),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StandardText.headline1(
            context,
            title,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
          4.horizontalSpace,
          InkWell(
            onTap: onTapClose,
            child: const Icon(
              Icons.close,
              color: AppColors.black,
              size: 16,
            ),
          )
        ],
      ),
    );
  }
}
