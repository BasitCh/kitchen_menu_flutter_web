import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class RecipeIngredients extends StatelessWidget {
  const RecipeIngredients({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 5,
      child: BaseScaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  5.horizontalGap,
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StandardText.headline1(
                            context,
                            'Create a recipe',
                            fontFamily: Assets.fonts.yugothicLight,
                            fontSize: 35.sp,
                            fontWeight: FontWeight.w300,
                            color: AppColors.textBlack80,
                          ),
                          12.verticalGap,
                          StandardText.headline1(
                            context,
                            'Enter the basic information of recipe i.e photos, name, description etc to createa new recipe in Admins Library',
                            fontFamily: Assets.fonts.yugothicLight,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textBlack60,
                          ),
                          12.verticalGap,
                          Row(
                            children: [
                              StandardText.headline1(
                                context,
                                'INGREDIENTS',
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textBlack80,
                              ),
                              2.horizontalGap,
                              StandardText.headline1(
                                context,
                                '(step2/4)',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textBlack80,
                              ),
                            ],
                          ),
                          8.verticalGap,
                          Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            width: 200,
                            // height: MediaQuery.of(context).size.height/90,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.seaGreen, width: 1),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: const LinearProgressIndicator(
                              backgroundColor: AppColors.transparent,
                              color: AppColors.seaGreen,
                              //minHeight: 15,
                              value: 2,
                            ),
                          ),
                          //const recipiesCreate(),

                          12.verticalGap,
                          Row(
                            children: [
                              StandardText.headline1(
                                context,
                                'SELECT A CATAGORY',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textBlack80,
                              ),
                              StandardText.headline1(
                                context,
                                '*',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: AppColors.red,
                              ),
                            ],
                          ),
                          AppDropdown(
                            hintText: 'Breakfast',
                            data: [],
                            onChanged: (z) {},
                            backgroundColor: AppColors.white,
                            borderColor: AppColors.gray,
                          ),
                          10.verticalGap,
                          Row(
                            children: [
                              StandardText.headline1(
                                context,
                                'APPLIED FILTERS',
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textBlack80,
                              ),
                              Spacer(),
                              StandardText.headline1(
                                context,
                                'Clear Filters',
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: AppColors.accent,
                              ),
                              6.horizontalGap,
                              Assets.icons.icCancel
                                  .svg(color: AppColors.accent),
                              6.horizontalGap,
                            ],
                          ),
                          12.verticalGap,
                          FilterTile(
                            title: 'hello',
                          ),
                          30.verticalGap,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 65,
                                width: 450,

                                margin: const EdgeInsets.only(left: 40),

                                decoration: const BoxDecoration(
                                  color: AppColors.mahroon,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    StandardText.headline1(
                                      context,
                                      'Next',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.white,
                                    ),
                                  ],
                                ),
                                //width: 750,
                              ),
                            ],
                          ),
                        ]),
                  ),
                  const Spacer(),
                  2.horizontalGap,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
