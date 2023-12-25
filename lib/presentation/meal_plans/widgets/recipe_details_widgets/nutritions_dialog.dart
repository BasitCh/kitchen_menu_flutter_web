import 'package:flutter/material.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'nutrition_information.dart';
import 'package:widgets_book/widgets_book.dart';

Future<Object> showNutritionsDialog({required BuildContext context}) async {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            getIt<NavigationService>()
                                .navigateBack(context: context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.black,
                          )),
                    ),
                    NutritionInformationSheet(
                      isManager: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
