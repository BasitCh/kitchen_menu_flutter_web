import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AllergyItem extends StatelessWidget {
  const AllergyItem({
    required this.title,
    this.padding,
    this.color,
    this.textColor,
    super.key,
  });

  final String title;
  final EdgeInsets? padding;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 10,
          ),
      decoration: BoxDecoration(
        color: color ?? AppColors.charcool,
        borderRadius: BorderRadius.circular(50),
      ),
      child: StandardText.subtitle2(
        context,
        title,
        fontSize: 12.sp,
        color: textColor ?? AppColors.white,
      ),
    );
  }
}
