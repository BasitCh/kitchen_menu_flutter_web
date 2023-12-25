import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppRadioListTile<T> extends StatelessWidget {
  const AppRadioListTile({
    required this.value,
    required this.groupValue,
    super.key,
    this.title,
    this.subtitle,
    this.isSelected=false,
    this.onChanged,
  });

  final T value;
  final T? groupValue;
  final void Function(T?)? onChanged;
  final String? title;
  final String? subtitle;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      tileColor: isSelected ? AppColors.secondary : null,
      contentPadding: EdgeInsets.zero,
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      title: StandardText.subtitle2(
        context,
        title??'',
        fontWeight: AppFontWeight.medium,
        fontSize: 14.sp,
      ),
      subtitle: StandardText.subtitle2(
        context,
        subtitle??'',
        fontSize: 12.sp,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(
          color: AppColors.black600,
        ),
      ),

    );
  }
}
