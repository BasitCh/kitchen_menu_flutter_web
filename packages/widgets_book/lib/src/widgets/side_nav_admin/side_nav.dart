import 'package:flutter/material.dart';
import 'package:widgets_book/src/widgets/side_nav_admin/drawer_tile.dart';
import 'package:widgets_book/widgets_book.dart';

class SideNav extends StatelessWidget {
  const SideNav({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Drawer(
        backgroundColor: AppColors.white900,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              flex: 5,
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                ),
                child: DrawerHeader(
                  child: Assets.images.appLogoPng.image(),
                ),
              ),
            ),
            Expanded(
              flex: 13,
              child: ListView(
                shrinkWrap: true,
                children: [
                  DrawerListTile(
                      title: 'Home',
                      svgSrc: Assets.icons.icDone.path,
                      onPress: () {
                        //DashboardController.to.movePage(0);
                      }),
                  DrawerListTile(
                    title: 'Reports',
                    svgSrc: Assets.icons.icDone.path,
                    expandedTiles: [
                      ListTile(
                        //onTap: () => DashboardController.to.movePage(1),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 70),
                          child: StandardText.headline5(
                            context,
                            'Executive Summary',
                            align: TextAlign.start,
                          ),
                        ),
                      ),
                      ListTile(
                        // onTap: () => DashboardController.to.movePage(2),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 70),
                          child: StandardText.body2(
                            context,
                            'Audit Report',
                          ),
                        ),
                      ),
                      ListTile(
                        //onTap: () => DashboardController.to.movePage(3),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 70),
                          child: StandardText.body2(
                            context,
                            'Corrective Action Report',
                          ),
                        ),
                      ),
                    ],
                  ),
                  DrawerListTile(
                    title: 'Questionnaires',
                    svgSrc: Assets.icons.icDone.path,
                    expandedTiles: [
                      ListTile(
                        //onTap: () => DashboardController.to.movePage(4),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 70),
                          child: StandardText.body2(
                            context,
                            'Foundation Questionnaire',
                          ),
                        ),
                      ),
                      ListTile(
                        //onTap: () => DashboardController.to.movePage(5),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 70),
                          child: StandardText.body2(
                            context,
                            'Pulse Questionnaire',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
