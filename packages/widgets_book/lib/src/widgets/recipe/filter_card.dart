import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class ElevatedCard extends StatelessWidget {
  const ElevatedCard({
    required this.child,
    Key? key,
    this.backgroundColor,
    this.onTap,
  }) : super(key: key);

  final Widget child;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 18,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: backgroundColor ?? AppColors.white,
          ),
          child: child,
        ),
      ),
    );
  }
}
