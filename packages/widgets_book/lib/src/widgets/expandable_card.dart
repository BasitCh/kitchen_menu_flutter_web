import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppExpandableCard extends StatefulWidget {
  const AppExpandableCard({
    required this.title,
    required this.children,
    super.key,
  });

  final String title;
  final List<Widget> children;

  @override
  State<AppExpandableCard> createState() => _AppExpandableCardState();
}

class _AppExpandableCardState extends State<AppExpandableCard> {
  // bool _isExpanded = false;
  ValueNotifier<bool> _isExpanded = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isExpanded,
      builder: (context, isExpanded, child) {
        return Column(
          children: [
            ListTile(
              tileColor: isExpanded ? AppColors.lightPink100 : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              contentPadding: isExpanded
                  ? const EdgeInsets.symmetric(horizontal: 15)
                  : EdgeInsets.zero,
              onTap: () {
                _isExpanded.value = !isExpanded;
              },
              title: StandardText.subtitle2(
                context,
                widget.title,
                fontSize: 18.sp,
                fontWeight: AppFontWeight.bold,
                color: isExpanded ? AppColors.black : AppColors.stepGrey,
              ),
              trailing: !isExpanded
                  ? Assets.icons.icAdd.svg(
                      width: 30.h,
                      height: 30.h,
                    )
                  : Assets.icons.icCollapse.svg(
                      width: 30.h,
                      height: 30.h,
                    ),
            ),
            if (isExpanded) ...widget.children,
            const AppDivider(
              color: AppColors.grey500,
            ),
          ],
        );
      },
    );
  }
}
