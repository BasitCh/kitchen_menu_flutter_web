import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AllergyLabel extends StatelessWidget {
  const AllergyLabel({required this.allergy, super.key});
  final String allergy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      margin: const EdgeInsets.only(
        right: 4,
        top: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColors.charcoal,
      ),
      child: StandardText.subtitle3(
        context,
        allergy,
        color: AppColors.white,
      ),
    );
  }
}
