import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class BaseAppbarUser extends StatelessWidget {
  const BaseAppbarUser({
    required this.title,
    this.onTapLeading,
    super.key,
  });

  final VoidCallback? onTapLeading;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: onTapLeading,
        child: Assets.icons.arrowLeft.svg(
          width: 28.h,
          height: 28.h,
          fit: BoxFit.scaleDown,
        ),
      ),
      centerTitle: true,
      title: StandardText.headline5(
        context,
        title,
        fontSize: 17.sp,
      ),
    );
  }
}
