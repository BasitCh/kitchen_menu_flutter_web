import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/main/cubit/main_navbar_cubit.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/presentation/chefs/widgets/dashboard_item.dart';
import 'package:menumaster_manager/presentation/widgets/app_bar.dart';
import 'package:widgets_book/widgets_book.dart';

class UserArgs {
  String userId;
  UserArgs({
    required this.userId,
  });
}

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({
    super.key,
  });

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarHeight: 80,
      appBar: const ManagerBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: context.width / 5),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              50.verticalGap,
              StandardText.headline1(
                context,
                'DASHBOARD',
                fontFamily: Assets.fonts.yugothicLight,
                fontSize: 40,
                fontWeight: FontWeight.w300,
                color: AppColors.textBlack80,
                align: TextAlign.start,
              ),
              50.verticalGap,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: DashBoardItem(
                        icon: Assets.images.chefIcon.svg(
                          width: 105,
                          height: 105,
                          colorFilter: const ColorFilter.mode(
                              AppColors.transparent, BlendMode.clear),
                        ),
                        title: 'Chefs',
                        description: 'View all chefs',
                        onClick: () {
                          getIt<NavigationService>().navigateToNamed(
                              context: context,
                              uri: NavigationService.chefsUri);
                        }),
                  ),
                  2.horizontalGap,
                  Expanded(
                      child: DashBoardItem(
                    icon: Assets.images.mealIcon.svg(
                      width: 105,
                      height: 105,
                      colorFilter: const ColorFilter.mode(
                          AppColors.transparent, BlendMode.clear),
                    ),
                    title: 'Meal Plans',
                    description: 'My revolving menu',
                    onClick: () {
                      BlocProvider.of<MainNavBarCubit>(context)
                          .changeDrawerNavBar(2);
                      // change it to company chef list
                      getIt<NavigationService>().replaceWithNamed(
                        context: context,
                        uri: NavigationService.companyChefsUri,
                      );
                    },
                  )),
                ],
              ),
              7.verticalGap,
              SizedBox(
                  width: context.width,
                  child: DashBoardItem(
                    icon: Assets.images.allergiesIcon.svg(
                      width: 105,
                      height: 105,
                      colorFilter: const ColorFilter.mode(
                          AppColors.transparent, BlendMode.clear),
                    ),
                    title: 'Allergies Registry',
                    description: 'View all children with allergies',
                    onClick: () {
                      BlocProvider.of<MainNavBarCubit>(context)
                          .changeDrawerNavBar(3);
                      getIt<NavigationService>().replaceWithNamed(
                          context: context,
                          uri: NavigationService.childrenWithAllergiesUri);
                    },
                  )),
              30.verticalGap,
            ],
          ),
        ),
      ),
    );
  }
}
