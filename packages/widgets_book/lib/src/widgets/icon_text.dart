// ignore_for_file: always_specify_types

import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class IconText extends StatelessWidget {
  const IconText({
    required this.iconPathSvg,
    required this.standardText,
    super.key,
  });

  final String iconPathSvg;
  final StandardText standardText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        28.horizontalGap,
        SvgPicture.asset(
          iconPathSvg,
        ),
        5.horizontalGap,
        Expanded(child: standardText)
      ],
    );
  }
}
