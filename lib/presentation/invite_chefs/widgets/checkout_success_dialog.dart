import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

Future<Object> showCheckoutSuccessDialog(
    {required BuildContext context}) async {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      final currentDateTime = DateTime.now();
      return Center(
        child: Container(
          width: 700,
          height: 580,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Scaffold(
            backgroundColor: AppColors.transparent,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(buildContext).pop();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: AppColors.black,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        50.verticalGap,
                        const Icon(
                          Icons.check,
                          color: AppColors.greenDark,
                          size: 80,
                        ),
                        30.verticalGap,
                        StandardText.headline6(
                          context,
                          'Congratulations',
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                        30.verticalGap,
                        RichText(
                          text: TextSpan(
                            style: UITextStyle.subtitle3.copyWith(fontSize: 14),
                            children: <TextSpan>[
                              const TextSpan(
                                text: 'Monthly Membership ',
                              ),
                              TextSpan(
                                  text:
                                      '${DateFormat('MMMM dd').format(currentDateTime)} - ${DateFormat('MMMM dd').format(DateTime(currentDateTime.year, currentDateTime.month + 1, currentDateTime.day))}',
                                  style: UITextStyle.subtitle3.copyWith(
                                      fontSize: 14,
                                      decoration: TextDecoration.underline)),
                            ],
                          ),
                        ),
                        15.verticalGap,
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: UITextStyle.subtitle3.copyWith(fontSize: 13),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      'Your invite of membership, to your selected chefs, has been sent successfully.',
                                  style: UITextStyle.subtitle3
                                      .copyWith(color: AppColors.textBlack60)),
                            ],
                          ),
                        ),
                        40.verticalGap,
                        SizedBox(
                          width: kIsWeb ? context.width / 5 : context.width / 3,
                          child: AppButton.darkRed(
                            onPressed: () {
                              Navigator.of(buildContext).pop();
                            },
                            radius: 8,
                            child: StandardText.buttonLarge(
                              'GO TO HOME',
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
