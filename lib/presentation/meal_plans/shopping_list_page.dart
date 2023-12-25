// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:menumaster_manager/application/meal_plans/cubits/create_shopping_list_cubit.dart';
import 'package:menumaster_manager/presentation/meal_plans/widgets/shopping_list_estimate_costing.dart';
import 'package:menumaster_manager/presentation/meal_plans/widgets/shopping_list_ingredient_header.dart';
import 'package:menumaster_manager/presentation/widgets/app_bar.dart';
import 'package:widgets_book/widgets_book.dart';
import 'package:file_saver/file_saver.dart';
import 'widgets/shopping_list_ingredients.dart';

class MealPlanShoppingListPage extends StatefulWidget {
  const MealPlanShoppingListPage({Key? key}) : super(key: key);

  @override
  State<MealPlanShoppingListPage> createState() =>
      _MealPlanShoppingListPageState();
}

class _MealPlanShoppingListPageState extends State<MealPlanShoppingListPage> {
  final GlobalKey _repaintKey = GlobalKey();

  resetList(BuildContext context) {
    context.read<CreateShoppingListCubit>().reset();
  }

  @override
  Widget build(BuildContext context) {
    resetList(context);
    return BaseScaffold(
      appBar: const ManagerBar(),
      appBarHeight: 80,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.verticalSpace,
              StandardText.headline3(
                context,
                'Shopping List',
              ),
              10.verticalSpace,
              Container(
                padding: EdgeInsets.only(right: 50.h),
                child: StandardText.subtitle2(
                  context,
                  'Create a shopping list as per the revolving menu of selected week.',
                  letterSpacing: -0.4,
                  fontSize: 14.sp,
                  color: AppColors.textBlack50,
                ),
              ),
              25.verticalSpace,
              RepaintBoundary(
                key: _repaintKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 3,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            const ShoppingListIngredientHeader(),
                            const AppDivider(),
                            const ShoppingListIngredients(),
                            10.verticalSpace,
                          ],
                        ),
                      ),
                    ),
                    // 25.verticalSpace,
                    // const AppDivider(
                    //   color: AppColors.rose,
                    // ),
                    // 10.verticalSpace,
                    // const ShoppingListEstimateCosting(),
                    // 10.verticalSpace,
                    // const AppDivider(
                    //   color: AppColors.rose,
                    // ),
                    30.verticalSpace,
                  ],
                ),
              ),
              BlocBuilder<CreateShoppingListCubit, bool>(
                builder: (context, state) {
                  return Column(
                    children: [
                      if (!state)
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width:
                                kIsWeb ? context.width / 4 : context.width * 3,
                            child: AppButton.darkRed(
                              child: StandardText.buttonLarge(
                                'save shopping list'.toUpperCase(),
                              ),
                              onPressed: () {
                                context
                                    .read<CreateShoppingListCubit>()
                                    .initialize(true);
                              },
                            ),
                          ),
                        ),
                      if (state) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: kIsWeb
                                  ? context.width / 4
                                  : context.width * 3,
                              child: AppButton.darkRed(
                                child: StandardText.buttonLarge(
                                  'save photo'.toUpperCase(),
                                ),
                                onPressed: () async {
                                  try {
                                    // Run the isolateSavePhoto function in an isolate
                                    final image = await compute(
                                        captureAndSaveImage,
                                        _repaintKey.currentContext!
                                                .findRenderObject()
                                            as RenderRepaintBoundary);

                                    FileSaver.instance.saveFile(
                                        name:
                                            'shopping_list_${DateTime.now().toIso8601String()}.png',
                                        bytes: image);
                                  } catch (e) {
                                    // print(e);
                                  } finally {}
                                },
                              ),
                            ),
                            5.horizontalGap,
                            SizedBox(
                              width: kIsWeb
                                  ? context.width / 4
                                  : context.width * 3,
                              child: AppButton.outlinedDarkRed(
                                child: StandardText.buttonLarge(
                                  'edit list'.toUpperCase(),
                                  color: AppColors.accent,
                                ),
                                onPressed: () {
                                  context
                                      .read<CreateShoppingListCubit>()
                                      .initialize(false);
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ],
                  );
                },
              ),
              50.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Future<Uint8List?> captureAndSaveImage(RenderRepaintBoundary boundary) async {
    final image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);

    if (byteData != null) {
      Uint8List pngBytes = byteData.buffer.asUint8List();
      return pngBytes;
    } else {
      return null;
    }
  }
}
