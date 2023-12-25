import 'package:flutter/cupertino.dart';
import 'package:widgets_book/widgets_book.dart';

class FilterTile extends StatelessWidget {
  const FilterTile({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 236,
      height: 56,
      decoration: BoxDecoration(
          color: AppColors.charcool, borderRadius: BorderRadius.circular(50)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StandardText.headline1(
            context,
            title,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
          30.horizontalGap,
          Assets.icons.icCancel.svg(),
        ],
      ),
    );
  }
}
