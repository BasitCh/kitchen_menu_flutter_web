import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class SplashLoading extends StatelessWidget {
  const SplashLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StandardText.subtitle2(
      context,
      AppLocalizations.of(context)!.splash_loading,
      color: AppColors.white,
      fontWeight: AppFontWeight.bold,
      letterSpacing: 0.8,
    );
  }
}
