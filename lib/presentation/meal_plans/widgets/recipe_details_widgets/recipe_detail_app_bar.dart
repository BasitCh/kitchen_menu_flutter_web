import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

String imgUrl =
    'https://www.greatgrubdelicioustreats.com/wp-content/uploads/2017/10/P1044751..jpg';

class RecipeDetailAppBar extends StatelessWidget {
  const RecipeDetailAppBar(
      {Key? key,
      required this.title,
      required this.description,
      required this.imageUrl})
      : super(key: key);

  final String title;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: context.width,
            height: 400.h,
            errorBuilder: (context, _, __) {
              return Container(
                width: context.width,
                color: AppColors.accent,
              );
            },
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
              width: context.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.transparent,
                    AppColors.gray,
                  ],
                ),
              ),
              child: Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.start,
                children: [
                  StandardText.headline5(
                    context,
                    title,
                    fontSize: 28.sp,
                    color: AppColors.white,
                    fontWeight: AppFontWeight.medium,
                  ),
                  2.verticalSpace,
                  StandardText.subtitle2(
                    context,
                    description,
                    color: AppColors.white,
                    fontSize: 14.sp,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   top: 0,
          //   child: Container(
          //     width: context.width,
          //     height: context.height * .1,
          //     color: AppColors.black200,
          //   ),
          // ),
        ],
      ),
    );
  }
}
