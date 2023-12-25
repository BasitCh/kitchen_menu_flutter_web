import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:widgets_book/widgets_book.dart';

class AppStandardTextField extends StatelessWidget {
  const AppStandardTextField({
    super.key,
    this.width,
    this.textFieldColor,
    this.borderColor,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.controller,
    this.showPrefixIcon = true,
    this.showSuffixIcon = true,
    this.prefixText,
    this.prefixWidget,
    this.suffixWidget,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.textAlign = TextAlign.left,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.isEnabled = true,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autoCorrect = true,
    this.maxLength,
    this.maxLines = 1,
    this.inputBorder,
    this.inputFormatter,
    this.autoFocus = false,
    this.focusNode,
    this.validator,
    this.cursorColor,
    this.validate,
    this.readOnly = false,
    this.showCounterText = false,
    this.borderRadius = 0,
    this.filled = true,
    this.fillColor = AppColors.transparent,
    this.errorHeight,
    this.disableSpacing = false,
    this.autoValidateMode,
    this.obscuringCharacter,
    this.contentPadding,
  });

  const AppStandardTextField.outlined({
    super.key,
    this.width,
    this.textFieldColor,
    this.borderColor = AppColors.black600,
    this.hintText,
    this.labelText,
    this.hintStyle,
    this.labelStyle,
    this.controller,
    this.showPrefixIcon = true,
    this.showSuffixIcon = true,
    this.prefixText,
    this.prefixWidget,
    this.suffixWidget,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.textAlign = TextAlign.left,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.isEnabled = true,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autoCorrect = true,
    this.maxLength,
    this.maxLines = 1,
    this.inputBorder,
    this.inputFormatter,
    this.autoFocus = false,
    this.focusNode,
    this.validator,
    this.cursorColor,
    this.validate,
    this.readOnly = false,
    this.showCounterText = false,
    this.borderRadius = 10,
    this.filled = true,
    this.fillColor = AppColors.white800,
    this.errorHeight,
    this.disableSpacing = false,
    this.autoValidateMode,
    this.obscuringCharacter,
    this.contentPadding,
  });

  final double? width;
  final Color? textFieldColor;
  final Color? borderColor;
  final Color? cursorColor;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextEditingController? controller;
  final Widget? prefixWidget;
  final String? prefixText;
  final Widget? suffixWidget;
  final void Function(String value)? onChanged;
  final void Function(String value)? onFieldSubmitted;
  final void Function(String? value)? onSaved;
  final void Function()? onTap;
  final void Function()? onEditingComplete;

  final bool showPrefixIcon;
  final bool showCounterText;
  final bool showSuffixIcon;
  final bool isEnabled;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autoCorrect;
  final int? maxLength;
  final int? maxLines;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final InputBorder? inputBorder;
  final List<TextInputFormatter>? inputFormatter;
  final bool autoFocus;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final bool? validate;
  final bool readOnly;
  final double borderRadius;
  final Color fillColor;
  final bool filled;
  final double? errorHeight;
  final bool? disableSpacing;
  final AutovalidateMode? autoValidateMode;
  final String? obscuringCharacter;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      maxLines: maxLines,
      obscureText: obscureText,
      obscuringCharacter: '*',
      enableSuggestions: enableSuggestions,
      autocorrect: autoCorrect,
      style: UITextStyle.bodyText2.copyWith(fontSize: 14.flexibleFontSize),
      buildCounter: maxLength == null
          ? null
          : (
              _, {
              required int currentLength,
              required bool isFocused,
              required int? maxLength,
            }) =>
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 17.h),
                child: StandardText.subtitle3(
                  context,
                  '$currentLength/$maxLength',
                  color: AppColors.gray,
                ),
              ),
      decoration: InputDecoration(
        fillColor: fillColor,
        // counterText: maxLength != null ? '${controller?.text.length??0}/$maxLength' : null,
        counterStyle: UITextStyle.bodyText2,
        filled: filled,
        errorStyle: TextStyle(
          color: Colors.red,
          height: errorHeight,
          fontSize: 11,
        ),
        hintText: hintText,
        labelText: labelText,
        hintStyle:
            hintStyle ?? UITextStyle.bodyText2.copyWith(color: AppColors.grey),
        border: inputBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.gray,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
        focusedBorder: inputBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.gray,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
        errorBorder: inputBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.red,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
        disabledBorder: inputBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.gray,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
        enabledBorder: inputBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(
                color: borderColor ?? AppColors.gray,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius),
              ),
            ),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 10,
            ),
        labelStyle: UITextStyle.bodyText2.copyWith(
          color: (focusNode != null &&
                  focusNode!.hasFocus &&
                  validate != null &&
                  !validate!)
              ? Colors.red
              : (focusNode != null &&
                      focusNode!.hasFocus &&
                      validate != null &&
                      validate!)
                  ? AppColors.primary
                  : const Color(0xFF4B5563),
        ),
        suffixIcon: showSuffixIcon ? suffixWidget : null,
        prefixIcon: showPrefixIcon ? prefixWidget : null,
        prefixText: prefixText,
        prefixStyle: UITextStyle.bodyText1.copyWith(
          fontSize: 14.flexibleFontSize,
          color: AppColors.black,
        ),
      ),
      controller: controller,
      textAlign: textAlign,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      onTap: onTap,
      enabled: isEnabled,
      inputFormatters: disableSpacing!
          ? [
              FilteringTextInputFormatter.deny(
                RegExp(r'\s'),
              ),
            ]
          : inputFormatter ?? [NoLeadingSpaceFormatter()],
      autofocus: autoFocus,
      focusNode: focusNode,
      validator: validator,
      cursorColor: cursorColor ?? AppColors.primary,
      autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
    );
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final timedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: timedText,
        selection: TextSelection(
          baseOffset: timedText.length,
          extentOffset: timedText.length,
        ),
      );
    }

    return newValue;
  }
}
