import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppliedFilterItem extends StatelessWidget {
  const AppliedFilterItem({
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
        borderRadius: BorderRadius.circular(25),
        color: AppColors.charcoal,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StandardText.subtitle3(
            context,
            title,
            color: AppColors.white,
          ),
          4.horizontalSpace,
          InkWell(
            onTap: onTapClose,
            child: const Icon(
              Icons.close,
              color: AppColors.white,
              size: 12,
            ),
          )
        ],
      ),
    );
  }
}
