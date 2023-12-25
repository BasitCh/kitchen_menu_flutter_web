// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:menumaster_manager/application/main/cubit/main_navbar_cubit.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/infrastructure/services/shared_preferences_helper.dart';
import 'package:menumaster_manager/presentation/home/widgets/drawer_item.dart';
import 'package:widgets_book/widgets_book.dart';

class Homepage extends StatefulWidget {
  const Homepage({required this.navigationShell, Key? key}) : super(key: key);
  final StatefulNavigationShell navigationShell;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    context.read<MainNavBarCubit>().changeDrawerNavBar(0);
                    getIt<NavigationService>().replaceWithNamed(
                        context: context, uri: NavigationService.dashBoardUri);
                  },
                  child: Column(
                    children: [
                      20.verticalGap,
                      Assets.images.appLogoPng.image(height: 125, width: 125),
                      30.verticalSpace,
                    ],
                  ),
                ),
                50.verticalGap,
                Column(
                  children: getDrawerItems,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset.zero,
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.navigationShell,
          ),
        ],
      ),
    );
  }

  void onPageChange(int index) {
    BlocProvider.of<MainNavBarCubit>(this.context).changeDrawerNavBar(index);
    // widget.navigationShell.goBranch(index);
    if (index == 0) {
      getIt<NavigationService>().replaceWithNamed(
          context: this.context, uri: NavigationService.dashBoardUri);
    } else if (index == 1) {
      getIt<NavigationService>().replaceWithNamed(
          context: this.context, uri: NavigationService.inviteChefsUri);
    } else if (index == 2) {
      getIt<NavigationService>().replaceWithNamed(
          context: this.context, uri: NavigationService.companyChefsUri);
    } else if (index == 3) {
      getIt<NavigationService>().replaceWithNamed(
          context: this.context,
          uri: NavigationService.childrenWithAllergiesUri);
    }
  }

  List<Widget> get getDrawerItems {
    final drawerItems = [
      DrawerItem(
        leadingWidget: Assets.icons.chefsMenuIcon.svg(),
        text: 'Chefs',
        index: 0,
        onTap: () {
          onPageChange(0);
        },
      ),
      DrawerItem(
        leadingWidget: Row(children: [
          Assets.icons.inviteArrowMenu.svg(),
          2.horizontalGap,
          Assets.icons.inviteMenu.svg()
        ]),
        index: 1,
        text: 'Invite Chefs',
        leadingIconSpace: 6.horizontalGap,
        onTap: () {
          onPageChange(1);
        },
      ),
      DrawerItem(
        leadingWidget: Assets.icons.mealMenu.svg(),
        text: 'Meal Plans',
        index: 2,
        onTap: () {
          onPageChange(2);
        },
      ),
      DrawerItem(
        leadingWidget: Assets.icons.allergiesMenu.svg(),
        text: 'Children with allergies',
        index: 3,
        onTap: () {
          onPageChange(3);
        },
      ),
      100.verticalGap,
      DrawerItem(
        leadingWidget: Assets.icons.logoutManager.svg(),
        text: 'Logout',
        index: 4,
        onTap: () async {
          await firebaseAuth.signOut();
          await SharedPreferenceService.delatePreferences();
          if (!mounted) return;
          getIt<NavigationService>().replaceWithNamed(
              context: this.context, uri: NavigationService.loginRouteUri);
        },
      ),
    ];
    return drawerItems;
  }
}
