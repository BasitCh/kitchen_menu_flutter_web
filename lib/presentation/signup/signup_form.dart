import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/signup/signup_bloc/signup_bloc.dart';
import 'package:menumaster_manager/application/signup/signup_cubit/signup_cubit.dart';
import 'package:widgets_book/widgets_book.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    Key? key,
    required this.formKey,
    required this.emailTextEditingController,
    required this.passwordTextEditingController,
    required this.confirmPasswordTextEditingController,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController emailTextEditingController;
  final TextEditingController passwordTextEditingController;
  final TextEditingController confirmPasswordTextEditingController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocBuilder<SignupCubit, SignupState>(builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: context.width / 4,
              child: AppTextField(
                controller: emailTextEditingController,
                key: const Key('loginForm_email'),
                suffix: state.isEmailValidated
                    ? Assets.icons.icDone.svg()
                    : crossIcon(),
                labelText: 'EMAIL ADDRESS',
                validator: (value) =>
                    context.read<SignupCubit>().validateEmail(value),
              ),
            ),
            5.verticalGap,
            SizedBox(
              width: context.width / 4,
              child: Stack(
                children: [
                  AppTextField(
                    controller: passwordTextEditingController,
                    obscureText: state.isPasswordObscureText,
                    labelText: 'PASSWORD',
                    validator: (value) =>
                        context.read<SignupCubit>().validatePassword(value),
                  ),
                  Positioned(
                    right: 0,
                    top: 5,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if (context
                                .read<SignupCubit>()
                                .state
                                .isPasswordObscureText) {
                              context
                                  .read<SignupCubit>()
                                  .obscurePassword(false);
                            } else {
                              context.read<SignupCubit>().obscurePassword(true);
                            }
                          },
                          child: state.isPasswordObscureText
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
                        state.isPasswordValidated
                            ? Assets.icons.icDone.svg()
                            : crossIcon(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            5.verticalGap,
            SizedBox(
              width: context.width / 4,
              child: Stack(
                children: [
                  AppTextField(
                    controller: confirmPasswordTextEditingController,
                    obscureText: state.isConfirmPasswordObscureText,
                    labelText: 'CONFIRM PASSWORD',
                    validator: (value) => context
                        .read<SignupCubit>()
                        .validateConfirmPassword(
                            password: value!,
                            confirmPassword:
                                passwordTextEditingController.text),
                  ),
                  Positioned(
                    right: 0,
                    top: 5,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if (context
                                .read<SignupCubit>()
                                .state
                                .isConfirmPasswordObscureText) {
                              context
                                  .read<SignupCubit>()
                                  .obscureConfirmPassword(false);
                            } else {
                              context
                                  .read<SignupCubit>()
                                  .obscureConfirmPassword(true);
                            }
                          },
                          child: state.isConfirmPasswordObscureText
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
                        state.isConfirmPasswordValidated
                            ? Assets.icons.icDone.svg()
                            : crossIcon(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            35.verticalSpace,
            SizedBox(
                width: context.width / 4,
                child: BlocBuilder<SignupBloc, RegisterState>(
                  builder: (context, state) {
                    return state is SigningUp
                        ? const AppButtonLoading()
                        : AppButton.darkRed(
                            // width: context.width,
                            // isLargeButton: false,
                            child: StandardText.buttonLarge(
                              AppLocalizations.of(context)!
                                  .signup_button
                                  .toUpperCase(),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                context.read<SignupBloc>().add(
                                      SignUp(
                                          email:
                                              emailTextEditingController.text,
                                          password:
                                              passwordTextEditingController
                                                  .text),
                                    );
                              }
                            },
                          );
                  },
                )),
            35.verticalSpace,
            Container(
              alignment: Alignment.center,
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text:
                      '${AppLocalizations.of(context)!.signup_by_signing_up}\n',
                  children: [
                    TextSpan(
                        text: AppLocalizations.of(context)!
                            .signup_terms_condition,
                        style: UITextStyle.subtitle2.copyWith(
                            color: AppColors.textBlack60,
                            fontWeight: AppFontWeight.light,
                            letterSpacing: -0.4,
                            decoration: TextDecoration.underline)),
                    TextSpan(
                      text: AppLocalizations.of(context)!.signup_and,
                    ),
                    TextSpan(
                        text:
                            AppLocalizations.of(context)!.signup_privacy_policy,
                        style: UITextStyle.subtitle2.copyWith(
                            color: AppColors.textBlack60,
                            fontWeight: AppFontWeight.light,
                            letterSpacing: -0.4,
                            decoration: TextDecoration.underline)),
                  ],
                  style: UITextStyle.subtitle2.copyWith(
                    color: AppColors.textBlack60,
                    fontWeight: AppFontWeight.light,
                    letterSpacing: -0.4,
                  ),
                ),
              ),
            ),
            20.verticalGap,
          ],
        );
      }),
    );
  }

  Widget crossIcon() {
    return const Icon(
      Icons.close,
      color: AppColors.accent,
      size: 25,
    );
  }
}
