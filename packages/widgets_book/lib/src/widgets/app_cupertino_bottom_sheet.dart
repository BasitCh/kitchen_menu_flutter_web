import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class CommonBottomSheet extends StatelessWidget {
  const CommonBottomSheet({
    required this.child,
    this.height,
    super.key,
  });

  final Widget child;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? context.height - 120,
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: child,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: EdgeInsets.only(top: 15.h),
                width: 44,
                height: 4.16,
                decoration: ShapeDecoration(
                  color: AppColors.rose,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
