// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets_book/widgets_book.dart';

/// {@template app_text_field}
/// A text field component based on material [TextFormField] widget with a
/// fixed, left-aligned label text displayed above the text field.
/// {@endtemplate}
class AppTextField extends StatelessWidget {
  /// {@macro app_text_field}
  const AppTextField({
    super.key,
    this.initialValue,
    this.autoFillHints,
    this.controller,
    this.inputFormatters,
    this.autocorrect = true,
    this.readOnly = false,
    this.hintText,
    this.errorText,
    this.prefix,
    this.suffix,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.labelText,
    this.validator,
    this.obscureText = false,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.textInputAction = TextInputAction.next,
    this.preFixText,
    this.maxLength,
    this.maxLines = 1,
  });
  // ignore: avoid_field_initializers_in_const_classes
  final fillcolor = AppColors.textfieldFill;
// ignore: avoid_field_initializers_in_const_classes, type_annotate_public_apis
  final hovercolor = AppColors.textfieldFill;
  // ignore: avoid_field_initializers_in_const_classes
  final bordersidecolor = const BorderSide(color: AppColors.textfieldBorder);
  // ignore: avoid_field_initializers_in_const_classes
  final focusedcolor = const BorderSide(color: AppColors.textfieldBorder);
  final FormFieldValidator<String>? validator;

  /// A value to initialize the field to.
  final String? initialValue;

  /// List of auto fill hints.
  final Iterable<String>? autoFillHints;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController? controller;

  /// Optional input validation and formatting overrides.
  final List<TextInputFormatter>? inputFormatters;

  /// Whether to enable autocorrect.
  /// Defaults to true.
  final bool autocorrect;

  /// Whether the text field should be read-only.
  /// Defaults to false.
  final bool readOnly;

  /// Text that suggests what sort of input the field accepts.
  final String? hintText;

  /// Text that appears below the field.
  final String? errorText;

  /// A widget that appears before the editable part of the text field.
  final Widget? prefix;

  /// A widget that appears after the editable part of the text field.
  final Widget? suffix;

  /// The type of keyboard to use for editing the text.
  /// Defaults to [TextInputType.text] if maxLines is one and
  /// [TextInputType.multiline] otherwise.
  final TextInputType? keyboardType;

  /// Called when the user inserts or deletes texts in the text field.
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final ValueChanged<String>? onSubmitted;

  /// Called when the text field has been tapped.
  final VoidCallback? onTap;
  final String? labelText;
  final bool obscureText;
  final AutovalidateMode? autoValidateMode;
  final TextInputAction? textInputAction;
  final String? preFixText;
  final int? maxLength;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 80),
          child: TextFormField(
            key: key,
            obscureText: obscureText,
            initialValue: initialValue,
            maxLength: maxLength,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            maxLines: maxLines,
            controller: controller,
            inputFormatters: inputFormatters ?? [NoLeadingSpaceFormatter()],
            keyboardType: keyboardType,
            autocorrect: autocorrect,
            readOnly: readOnly,
            validator: validator,
            autovalidateMode: autoValidateMode,
            autofillHints: autoFillHints,
            cursorColor: AppColors.darkAqua,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: AppColors.textBlack80,
                  fontFamily: Assets.fonts.poppinsRegular,
                ),
            onFieldSubmitted: onSubmitted,
            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              prefixIcon: prefix,
              prefixText: preFixText,
              contentPadding: const EdgeInsets.symmetric(vertical: 20),
              label: StandardText.headline1(
                context,
                labelText ?? '',
                color: AppColors.gray,
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              suffixIcon: suffix,
              fillColor: fillcolor,
              hoverColor: hovercolor,
              enabledBorder: UnderlineInputBorder(
                borderSide: bordersidecolor,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: focusedcolor,
              ),
              suffixIconConstraints: const BoxConstraints.tightFor(
                width: 32,
                height: 32,
              ),
              prefixIconConstraints: const BoxConstraints.tightFor(
                width: 48,
              ),
              errorStyle:
                  const TextStyle(color: AppColors.accent, fontSize: 12),
            ),
            onChanged: onChanged,
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
