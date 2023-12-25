import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      color: color??AppColors.gray700,
      height: 1,
    );
  }
}