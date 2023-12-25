import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/login/cubits/login_cubit.dart';
import 'package:widgets_book/widgets_book.dart';

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    super.key,
    required this.password,
    required this.isObscureText,
    required this.isPasswordValidated,
  });

  final TextEditingController password;
  final bool isObscureText;
  final bool isPasswordValidated;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width / 4,
      child: Stack(
        children: [
          AppTextField(
            controller: password,
            obscureText: isObscureText,
            labelText: 'PASSWORD',
            validator: (val) =>
                context.read<LoginCubit>().validatePassword(val),
            textInputAction: TextInputAction.done,
          ),
          Positioned(
            right: 0,
            child: Container(
              transform: Matrix4.translationValues(0, 7, 0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      isObscureText
                          ? context.read<LoginCubit>().obscurePassword(false)
                          : context.read<LoginCubit>().obscurePassword(true);
                    },
                    child: isObscureText
                        ? const Icon(
                            Icons.visibility_off,
                            color: AppColors.gray,
                            size: 20,
                          )
                        : const Icon(
                            Icons.visibility_rounded,
                            color: AppColors.gray,
                            size: 20,
                          ),
                  ),
                  isPasswordValidated ? Assets.icons.icDone.svg() : crossIcon()
                ],
              ),
            ),
          )
        ],
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
