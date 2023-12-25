import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/attendance_bloc/attendance_bloc.dart';
import 'package:widgets_book/widgets_book.dart';

class DayCheckBox extends StatelessWidget {
  const DayCheckBox({required this.day, required this.onChecked, super.key});

  final Day day;
  final Function(Day) onChecked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChecked(day);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
                activeColor: AppColors.black,
                value: day.isSelected,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                onChanged: (val) {
                  onChecked(day);
                }),
            StandardText.subtitle2(context, day.name),
            5.horizontalSpace,
          ],
        ),
      ),
    );
  }
}
