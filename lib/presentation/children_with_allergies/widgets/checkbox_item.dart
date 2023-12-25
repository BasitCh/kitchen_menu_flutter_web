import 'package:flutter/material.dart';
import 'package:menumaster_manager/domain/children_with_allergies/allergic_filter.dart';
import 'package:widgets_book/widgets_book.dart';

class CheckBoxItem extends StatelessWidget {
  const CheckBoxItem(
      {required this.filter, required this.onChecked, super.key});

  final AllergicFilter filter;
  final Function(AllergicFilter) onChecked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChecked(filter);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
                activeColor: AppColors.black,
                value: filter.isSelected,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (val) {
                  onChecked(filter);
                }),
            StandardText.subtitle2(context, filter.name),
            5.horizontalSpace,
          ],
        ),
      ),
    );
  }
}
