import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.backgroundColor = AppColors.white900,
    this.drawerIconColor,
    this.appBar,
    this.body,
    this.resizeToAvoidBottomInset = false,
    this.appBarHeight = 50,
  });
  final Widget? appBar;
  final Widget? body;
  final Color? backgroundColor;
  final Color? drawerIconColor;
  final bool? resizeToAvoidBottomInset;
  final double? appBarHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: backgroundColor,
      appBar: appBar != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(appBarHeight ?? 50),
              child: appBar!,
            )
          : null,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
                height: 380.h,
                width: 280.h,
                child: Assets.images.glove.svg(fit: BoxFit.fill),),
          ),
          if (body != null) body!,
        ],
      ),
    );
  }
}
