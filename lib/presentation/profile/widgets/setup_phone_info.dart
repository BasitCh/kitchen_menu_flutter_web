import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menumaster_manager/application/profile/cubits/selected_country_cubit.dart';
import 'package:widgets_book/widgets_book.dart';

class SetupPhoneInfo extends StatelessWidget {
  const SetupPhoneInfo({
    Key? key,
    required this.phoneTextEditingController,
  }) : super(key: key);

  final TextEditingController phoneTextEditingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StandardText.headline6(
          context,
          'Phone',
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        5.verticalSpace,
        Row(
          children: [
            Flexible(
              child: AppTextField(
                prefix: Center(
                  child: Container(
                      transform: Matrix4.translationValues(0, 10, 0),
                      child: BlocBuilder<SelectedCountryCubit, String?>(
                        builder: (context, country) {
                          return StandardText.body2(
                            context,
                            country == null
                                ? '+'
                                : country == 'New Zealand'
                                    ? '+64'
                                    : '+61',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.dullGrey,
                          );
                        },
                      )),
                ),
                controller: phoneTextEditingController,
                key: const Key('profile_phone'),
                suffix: Assets.icons.icDone.svg(),
                labelText: 'PHONE NUMBER',
                textInputAction: TextInputAction.next,
                validator: validateMobile,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
      ],
    );
  }
}
