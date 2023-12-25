import 'package:flutter/material.dart';
import 'package:menumaster_manager/domain/children_with_allergies/child.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/widgets/allergy_label.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/widgets/delete_child_dialog.dart';
import 'package:widgets_book/widgets_book.dart';

Future<Object> showChildDetailsDialog(
    {required BuildContext context, required Child child}) async {
  return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Container(
            width: 850,
            height: 600,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Scaffold(
              backgroundColor: AppColors.transparent,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          StandardText.headline6(
                            context,
                            child.childName ?? '',
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                          30.verticalGap,
                          StandardText.subtitle3(
                            context,
                            child.companyName ?? '',
                            color: AppColors.black,
                            fontSize: 17,
                          ),
                          15.verticalGap,
                          StandardText.subtitle3(
                            context,
                            'Notes: ${child.additionalNotes}',
                            color: AppColors.textBlack60,
                            fontSize: 15,
                          ),
                          30.verticalSpace,
                          if (child.weeklyAttendance != null &&
                              child.weeklyAttendance!.isNotEmpty) ...[
                            StandardText.subtitle3(
                              context,
                              'ATTENDANCE',
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),
                            10.verticalGap,
                            Wrap(
                                direction: Axis.horizontal,
                                children: child.weeklyAttendance!.map(
                                  (e) {
                                    return Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: Chip(
                                        labelPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 2.0,
                                                horizontal: 10.0),
                                        avatar: const Icon(
                                          Icons.check,
                                          color: AppColors.lightRed,
                                        ),
                                        label: StandardText.subtitle3(
                                          context,
                                          e,
                                          color: AppColors.charcool,
                                        ),
                                        backgroundColor: AppColors.lightPink100,
                                        elevation: 2.0,
                                        shadowColor: Colors.grey[30],
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 8.0),
                                      ),
                                    );
                                  },
                                ).toList()),
                            30.verticalGap,
                          ],
                          if (child.allergies != null &&
                              child.allergies!.isNotEmpty) ...[
                            StandardText.subtitle3(
                              context,
                              'ALLERGIES',
                              color: AppColors.textBlack,
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),
                            10.verticalGap,
                            Wrap(
                                direction: Axis.horizontal,
                                children: child.allergies!.map(
                                  (e) {
                                    return AllergyLabel(
                                      allergy: e,
                                    );
                                  },
                                ).toList())
                          ],
                          40.verticalGap,
                          Row(
                            children: [
                              Expanded(
                                child: AppButton.outlinedDarkRed(
                                  onPressed: () {
                                    Navigator.of(buildContext).pop();
                                    showDeleteChildDialog(
                                        context: context, child: child);
                                  },
                                  radius: 8,
                                  child: StandardText.buttonLarge(
                                    'REMOVE CHILD',
                                    color: AppColors.accent,
                                  ),
                                ),
                              ),
                              5.horizontalGap,
                              Expanded(
                                child: AppButton.darkRed(
                                  onPressed: () {
                                    Navigator.of(buildContext).pop();
                                    getIt<NavigationService>().navigateToNamed(
                                        context: context,
                                        uri: NavigationService.addChildUri,
                                        data: child);
                                  },
                                  radius: 8,
                                  child: StandardText.buttonLarge(
                                    'EDIT INFORMATION',
                                  ),
                                ),
                              ),
                            ],
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
      });
}
