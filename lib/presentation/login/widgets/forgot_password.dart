import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Forgot password?',
          style: UITextStyle.subtitle2.copyWith(
            color: AppColors.textBlack60,
            letterSpacing: -0.4,
          ),
        ),
      ),
    );
  }
}
