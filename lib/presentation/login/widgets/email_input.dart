import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/login/cubits/login_cubit.dart';
import 'package:widgets_book/widgets_book.dart';

class EmailInput extends StatelessWidget {
  const EmailInput(
      {super.key, required this.email, required this.isEmailValidated});

  final TextEditingController email;
  final bool isEmailValidated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width / 4,
      child: AppTextField(
        controller: email,
        key: const Key('loginForm_email'),
        suffix: isEmailValidated ? Assets.icons.icDone.svg() : crossIcon(),
        labelText: 'EMAIL ADDRESS',
        validator: (val) => context.read<LoginCubit>().validateEmail(val),
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget crossIcon() {
    return const Icon(
      Icons.close,
      color: AppColors.accent,
      size: 20,
    );
  }
}
