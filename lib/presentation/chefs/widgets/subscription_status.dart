import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class SubscriptionStatus extends StatelessWidget {
  const SubscriptionStatus(
      {super.key,
      this.padding,
      required this.status,
      required this.bgColor,
      required this.textColor});

  final EdgeInsetsGeometry? padding;
  final String status;
  final Color bgColor, textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ??
          const EdgeInsets.only(
            left: 30,
            right: 30,
            top: 2,
            bottom: 2,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: bgColor,
      ),
      child: StandardText.headline1(
        context,
        status,
        fontSize: 16,
        color: textColor,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
