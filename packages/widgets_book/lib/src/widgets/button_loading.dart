import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppButtonLoading extends StatelessWidget {
  const AppButtonLoading({
    super.key,
    this.color = AppColors.accent,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
        backgroundColor: AppColors.transparent,
      ),
    );
  }
}
