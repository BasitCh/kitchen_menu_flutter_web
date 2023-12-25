// ignore_for_file: inference_failure_on_function_return_type

import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppDropdown<T> extends StatelessWidget {
  const AppDropdown({
    required this.hintText,
    required this.onChanged,
    required this.data,
    this.backgroundColor,
    super.key,
    this.value,
    this.validator,
    this.radius = 8,
    this.borderColor = AppColors.gray700,
    this.filled = false,
    this.fillColor,
    this.iconSize,
  });

  const AppDropdown.filled({
    required this.hintText,
    required this.onChanged,
    required this.data,
    super.key,
    this.value,
    this.validator,
    this.radius = 0,
    this.borderColor = AppColors.gray700,
    this.filled = true,
    this.fillColor = AppColors.white700,
    this.backgroundColor,
    this.iconSize,
  });

  final T? value;
  final String hintText;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final List<DropdownMenuItem<T>> data;
  final Color? backgroundColor;
  final Color borderColor;
  final double radius;
  final bool filled;
  final Color? fillColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      decoration: InputDecoration(
        isCollapsed: true,
        border: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        errorStyle: UITextStyle.subtitle3.copyWith(
          color: AppColors.red,
        ),
        filled: filled,
        fillColor: fillColor,
      ),
      value: value,
      hint: StandardText.subtitle3(
        context,
        hintText,
        color: AppColors.gray,
      ),
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      icon: Icon(
        Icons.keyboard_arrow_down,
        size: iconSize ?? 16,
      ),
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      style: UITextStyle.subtitle3.copyWith(
        color: AppColors.gray,
        fontWeight: FontWeight.w600,
      ),
      items: data,
    );
  }
}
