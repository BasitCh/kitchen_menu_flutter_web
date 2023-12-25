import 'dart:math';

import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
  double get viewPaddingTop => MediaQuery.of(this).viewPadding.top;

  bool isTablet() {
    final size = MediaQuery.of(this).size;
    final diagonal =
        sqrt((size.width * size.width) + (size.height * size.height));
    final isTablet = diagonal > 1100.0;
    return isTablet;
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    String message,
  ) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(this).primaryColor,
          duration: const Duration(milliseconds: 1000),
          content: Text(
            message,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
          ),
        ),
      );
}
