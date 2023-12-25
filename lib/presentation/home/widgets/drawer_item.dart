import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/main/cubit/main_navbar_cubit.dart';
import 'package:widgets_book/widgets_book.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    super.key,
    this.containerPadding,
    this.leadingIconSpace,
    required this.leadingWidget,
    required this.text,
    required this.onTap,
    required this.index,
  });

  final EdgeInsetsGeometry? containerPadding;
  final Widget leadingWidget;
  final String text;
  final Widget? leadingIconSpace;
  final Function() onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: containerPadding ??
            const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child:
            BlocBuilder<MainNavBarCubit, int>(builder: (context, selectedItem) {
          return Row(children: [
            leadingIconSpace ?? 3.horizontalGap,
            leadingWidget,
            3.horizontalGap,
            StandardText.headline5(
              context,
              text,
              color: index == selectedItem
                  ? AppColors.accent
                  : AppColors.darkAccent,
            ),
            3.horizontalGap,
            index == selectedItem
                ? Container(
                    width: 5,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF771100),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  )
                : const SizedBox.shrink(),
          ]);
        }),
      ),
    );
  }
}
