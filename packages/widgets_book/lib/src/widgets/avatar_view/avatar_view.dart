
import 'package:flutter/material.dart';
import 'package:widgets_book/src/widgets/avatar_view/circular_widget.dart';
import 'package:widgets_book/src/widgets/avatar_view/rectangular_widget.dart';

class AvatarView extends StatefulWidget {

  const AvatarView(
      {super.key,
      this.avatarType = AvatarType.CIRCLE,
      this.isOnlyText = false,
      this.radius = 50,
      this.borderWidth = 0,
      this.borderColor,
      this.backgroundColor,
      this.foregroundColor,
      this.imagePath = "",
      this.text,
      this.onTap,
      this.placeHolder,
      this.errorWidget});
  final AvatarType avatarType;
  final bool isOnlyText;
  final double radius;

  final double borderWidth;

  final Color? borderColor;

  final Color? backgroundColor;

  final Color? foregroundColor;

  final String imagePath;

  final Text? text;

  final GestureTapCallback? onTap;

  final Widget? placeHolder;

  final Widget? errorWidget;

  @override
  _AvatarViewState createState() => _AvatarViewState();
}

class _AvatarViewState extends State<AvatarView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: widget.avatarType == AvatarType.CIRCLE
          ? CircularWidget(
              backgroundColor: widget.backgroundColor,
              borderColor: widget.borderColor,
              borderWidth: widget.borderWidth,
              errorWidget: widget.errorWidget,
              placeHolder: widget.placeHolder,
              imagePath: widget.imagePath,
              radius: widget.radius,
              foregroundColor: widget.foregroundColor,
              text: widget.text,
              isOnlyText: widget.isOnlyText,
            )
          : RectangularWidget(
              backgroundColor: widget.backgroundColor,
              borderColor: widget.borderColor,
              borderWidth: widget.borderWidth,
              errorWidget: widget.errorWidget,
              placeHolder: widget.placeHolder,
              imagePath: widget.imagePath,
              radius: widget.radius,
              foregroundColor: widget.foregroundColor,
              text: widget.text,
              isOnlyText: widget.isOnlyText,
            ),
    );
  }
}

enum AvatarType {
  CIRCLE,
  RECTANGLE,
}
