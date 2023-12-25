// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class ItemInvite extends StatelessWidget {
  ItemInvite({
    super.key,
  });

  TextEditingController emailController = TextEditingController(),
      nameController = TextEditingController(),
      centerNameController = TextEditingController(),
      feeController = TextEditingController(text: '\$35 / Month');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.verticalSpace,
          StandardText.subtitle3(
            context,
            'CHEF\'S EMAIL',
            color: AppColors.textBlack,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          8.verticalSpace,
          AppStandardTextField.outlined(
            key: UniqueKey(),
            controller: emailController,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            validator: validateEmail,
          ),
          15.verticalSpace,
          StandardText.subtitle3(
            context,
            'CHEF\'S NAME',
            color: AppColors.textBlack,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          8.verticalSpace,
          AppStandardTextField.outlined(
            key: UniqueKey(),
            controller: nameController,
            validator: (val) {
              if (val == null) {
                return 'please enter name';
              } else if (val.length < 3) {
                return 'Name must be of 3 characters';
              }
              return null;
            },
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          ),
          15.verticalGap,
          StandardText.subtitle3(
            context,
            'CENTER NAME',
            color: AppColors.textBlack,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          8.verticalSpace,
          AppStandardTextField.outlined(
            key: UniqueKey(),
            controller: centerNameController,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            validator: (val) {
              if (val == null) {
                return 'please enter name';
              } else if (val.length < 3) {
                return 'Name must be of 3 characters';
              }
              return null;
            },
          ),
          15.verticalSpace,
          StandardText.subtitle3(
            context,
            'PAY THE FEE',
            color: AppColors.textBlack,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          4.verticalSpace,
          AppStandardTextField.outlined(
            controller: feeController,
            isEnabled: false,
            keyboardType: TextInputType.phone,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          ),
          10.verticalGap
        ],
      ),
    );
  }

  String? validateEmail(String? val) {
    const emailRegex =
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
    if (val == null || val.isEmpty) {
      return 'Please enter chef\'s email address';
    } else if (!RegExp(emailRegex).hasMatch(val)) {
      return 'The email you entered is invalid';
    } else {
      return null;
    }
  }
}
