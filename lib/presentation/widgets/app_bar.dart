import 'package:flutter/material.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:widgets_book/widgets_book.dart';

class ManagerBar extends StatelessWidget {
  const ManagerBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        transform: Matrix4.translationValues(0, 10, 0),
        child: StandardText.headline1(
          context,
          'Manager Portal',
          fontFamily: Assets.fonts.yugothicBold,
          fontWeight: FontWeight.w700,
          align: TextAlign.center,
          fontSize: 30,
          color: AppColors.accent,
        ),
      ),
      leading: context.canPop()
          ? Container(
              transform: Matrix4.translationValues(0, 10, 0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                ),
                onPressed: () {
                  getIt<NavigationService>().navigateBack(context: context);
                },
              ),
            )
          : null,
      centerTitle: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            getIt<NavigationService>().navigateToNamed(
                context: context, uri: NavigationService.managerProfileUri);
          },
          child: Container(
            transform: Matrix4.translationValues(0, 5, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StandardText.headline1(
                      context,
                      'Welcome',
                      fontFamily: Assets.fonts.yugothicBold,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                    StandardText.body2(
                      context,
                      'Manager',
                      fontWeight: FontWeight.w200,
                    ),
                  ],
                ),
                5.horizontalGap,
                const Icon(
                  Icons.arrow_drop_down_sharp,
                ),
                10.horizontalGap,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
