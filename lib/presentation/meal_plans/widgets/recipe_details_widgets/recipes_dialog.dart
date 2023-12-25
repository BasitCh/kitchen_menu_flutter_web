import 'package:flutter/material.dart';
import 'package:menumaster_manager/domain/meal_plans/recipe.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:widgets_book/widgets_book.dart';

Future<Object> showRecipesDialog({
  required List<Recipe> recipes,
  required BuildContext context,
}) async {
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
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            getIt<NavigationService>()
                                .navigateBack(context: buildContext);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.black,
                          )),
                    ),
                    25.verticalGap,
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StandardText.headline1(
                            context,
                            recipes.first.foodCategory?.first.categoryName ??
                                '',
                            fontSize: 25.sp,
                            fontWeight: AppFontWeight.bold,
                            align: TextAlign.left,
                          ),
                          StandardText.subtitle2(
                            context,
                            'Total Recipes: ${recipes.length}',
                            color: AppColors.textBlack60,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14.sp,
                            align: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    25.verticalGap,
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 20),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: recipes.length,
                            itemBuilder: (context, index) {
                              return Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 20),
                                    leading: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: recipes[index]
                                                  .images
                                                  ?.first
                                                  .url !=
                                              null
                                          ? NetworkImage(
                                              recipes[index].images!.first.url!)
                                          : null,
                                      backgroundColor: AppColors.accent,
                                    ),
                                    title: StandardText.headline5(
                                      context,
                                      recipes[index].name ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 18.sp,
                                      fontWeight: AppFontWeight.bold,
                                      align: TextAlign.left,
                                    ),
                                    subtitle: StandardText.subtitle2(
                                      context,
                                      recipes[index].description ?? '',
                                      color: AppColors.textBlack60,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 14.sp,
                                      align: TextAlign.start,
                                    ),
                                    trailing: TextButton.icon(
                                        onPressed: () {
                                          getIt<NavigationService>()
                                              .navigateBack(
                                                  context: buildContext);
                                          getIt<NavigationService>()
                                              .navigateToNamed(
                                            context: context,
                                            uri: NavigationService
                                                .recipeDetailsUri,
                                            data: recipes[index].id ?? '',
                                          );
                                        },
                                        icon: Assets.icons.icEye.svg(),
                                        label: StandardText.headline6(
                                          context,
                                          'View Details',
                                          color: AppColors.accent,
                                        ))),
                              );
                            }),
                      ),
                    ),
                  ],
                )),
          ),
        );
      });
}
