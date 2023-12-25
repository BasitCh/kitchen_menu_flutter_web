import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {Key? key,
      required this.title,
      required this.svgSrc,
      this.onPress,
      this.expandedTiles})
      : super(key: key);

  final String title, svgSrc;
  final List<Widget>? expandedTiles;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return expandedTiles != null
        ? Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
            ),
            child: ExpansionTile(
              initiallyExpanded: true,
              trailing: const SizedBox(),
              title: StandardText.headline5(
                context,
                title,
                align: TextAlign.start,
              ),
              leading: SvgPicture.asset(svgSrc),
              children: expandedTiles ?? [],
              // onExpansionChanged: (value) {
              //   NotificationsController.to.demographicsOverlayController
              //       .closeMenu();
              // },
            ),
          )
        : ListTile(
            onTap: () {
              // NotificationsController.to.demographicsOverlayController
              //     .closeMenu();
              onPress?.call();
            },
            title: StandardText.headline5(
              context,
              title,
              align: TextAlign.start,
            ),
            leading: SvgPicture.asset(svgSrc),
          );
  }
}
