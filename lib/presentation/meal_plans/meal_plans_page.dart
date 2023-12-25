// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menumaster_manager/application/meal_plans/cubits/meal_plan_start_end_dates_cubit.dart';
import 'package:menumaster_manager/application/meal_plans/meal_plan_bloc/meal_plan_bloc.dart';
import 'package:menumaster_manager/application/meal_plans/shopping_list_bloc/shopping_list_bloc.dart';
import 'package:menumaster_manager/application/profile/user_profile_bloc/user_profile_bloc.dart';
import 'package:menumaster_manager/domain/meal_plans/meal_plan.dart';
import 'package:menumaster_manager/domain/meal_plans/recipe.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/presentation/meal_plans/widgets/meal_date_range.dart';
import 'package:menumaster_manager/presentation/meal_plans/widgets/meal_list.dart';
import 'package:menumaster_manager/presentation/meal_plans/widgets/user_details.dart';
import 'package:menumaster_manager/presentation/widgets/app_bar.dart';
import 'package:widgets_book/widgets_book.dart';
import 'package:file_saver/file_saver.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class MealPlansPage extends StatefulWidget {
  const MealPlansPage({
    super.key,
    required this.userId,
  });

  final String? userId;

  @override
  State<MealPlansPage> createState() => _MealPlansPageState();
}

class _MealPlansPageState extends State<MealPlansPage> {
  @override
  void initState() {
    super.initState();
    this
        .context
        .read<UserProfileBloc>()
        .add(FetchUserById(userId: widget.userId ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const ManagerBar(),
      appBarHeight: 80,
      body: BlocConsumer<UserProfileBloc, UserProfileState>(
          listener: (context, state) {
        if (state is UserLoaded) {
          final user = state.user;
          this.context.read<MealPlanStartEndDatesCubit>().initialize();
          var dates = this.context.read<MealPlanStartEndDatesCubit>().state;
          this.context.read<MealPlanBloc>().add(
                GetMealPlans(
                  userId: user?.id ?? '',
                  startDate: dates.startDate ?? DateTime.now(),
                  endDate: dates.endDate ?? DateTime.now(),
                ),
              );
        }
      }, builder: (context, userState) {
        return userState is UserLoaded
            ? SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(left: 40, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserDetails(
                        user: userState.user!,
                      ),
                      40.verticalGap,
                      BlocBuilder<MealPlanBloc, MealPlanState>(
                          builder: (context, state) {
                        return state is MealPlanFetched
                            ? StandardText.headline2(
                                context,
                                'revolving meal plan shared'.toUpperCase(),
                                fontSize: 20,
                                color: AppColors.black,
                                fontWeight: FontWeight.w900,
                              )
                            : const SizedBox.shrink();
                      }),
                      15.verticalGap,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MealDateRange(
                            userId: userState.user?.id ?? '',
                          ),
                          BlocBuilder<MealPlanBloc, MealPlanState>(
                              builder: (context, state) {
                            return state is MealPlanFetched
                                ? InkWell(
                                    radius: 30,
                                    onTap: () {
                                      downloadReportPDF(state.daywiseMealPlan);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 8),
                                      decoration: const BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30))),
                                      child: Row(
                                        children: [
                                          StandardText.buttonLarge(
                                            'Export',
                                            color: AppColors.black,
                                          ),
                                          2.horizontalSpace,
                                          Assets.icons.pdf.svg(),
                                        ],
                                      ),
                                    ),
                                  )
                                : const SizedBox.shrink();
                          })
                        ],
                      ),
                      30.verticalGap,
                      BlocListener<MealPlanBloc, MealPlanState>(
                        listener: (context, state) {
                          if (state is MealPlanFetched) {
                            List<Recipe> recipes = [];
                            final mealPlans = state.daywiseMealPlan.values;
                            mealPlans.every((plans) => plans.every((plan) {
                                  if (plan.recipes != null &&
                                      plan.recipes!.isNotEmpty) {
                                    plan.recipes
                                        ?.asMap()
                                        .forEach((index, recipe) {
                                      recipe = recipe.copyWith(
                                          noOfMealPlanChildren:
                                              plan.numberOfChildren);
                                      recipes.add(recipe);
                                    });
                                  }
                                  return true;
                                }));
                            context
                                .read<ShoppingListBloc>()
                                .add(FetchShoppingListEvent(
                                  recipes: recipes,
                                ));
                          }
                        },
                        child: BlocBuilder<MealPlanBloc, MealPlanState>(
                          builder: (context, state) {
                            return (state is LoadingMealPlans)
                                ? const Center(
                                    child: CircularProgressIndicator(
                                    color: AppColors.accent,
                                  ))
                                : (state is MealPlanFetched)
                                    ? MealList(
                                        daywiseMealPlan: state.daywiseMealPlan,
                                      )
                                    : state is ErrorFetchingMealPlans
                                        ? Center(
                                            child: StandardText.headline1(
                                              context,
                                              'No Menu Plan created by ${userState.user?.fullName}',
                                              color: AppColors.gray,
                                              fontSize: 45,
                                            ),
                                          )
                                        : const SizedBox.shrink();
                          },
                        ),
                      ),
                      20.verticalGap,
                      BlocBuilder<MealPlanBloc, MealPlanState>(
                        builder: (context, state) {
                          return (state is MealPlanFetched)
                              ? Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    width: kIsWeb
                                        ? context.width / 4
                                        : context.width * 3,
                                    child: AppButton.darkRed(
                                      child: StandardText.buttonLarge(
                                        'CREATE SHOPPING LIST',
                                      ),
                                      onPressed: () {
                                        getIt<NavigationService>()
                                            .navigateToNamed(
                                                context: context,
                                                uri: NavigationService
                                                    .shoppingListUri);
                                      },
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink();
                        },
                      ),
                      20.verticalGap,
                    ],
                  ),
                ),
              )
            : userState is LoadingUser
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : userState is ErrorLoadingUser
                    ? Center(
                        child: StandardText.headline1(
                          context,
                          userState.error,
                          color: AppColors.gray,
                          fontSize: 45,
                        ),
                      )
                    : const SizedBox.shrink();
      }),
    );
  }

  Future<void> downloadReportPDF(Map<Day, List<MealPlan>> plans) async {
    final daysOfWeek = [];
    final categories = [];
    for (final day in plans.keys.toList()) {
      daysOfWeek.add(day.day);
    }
    for (List<MealPlan> plans in plans.values.toList()) {
      for (MealPlan plan in plans) {
        categories.add(plan.category);
      }
    }

    //sort categories
    categories.sort((a, b) =>
        _categoriesOrder(a?.toLowerCase() ?? '') -
        _categoriesOrder(b?.toLowerCase() ?? ''));
    //
    final font = await PdfGoogleFonts.cormorantGaramondRegular();
    final pdfLogo = await _getPDFLogo();
    final pdf = pw.Document();

    final tableHeaders = <pw.Widget>[
      pw.Text('Category',
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          textAlign: pw.TextAlign.center),
      for (final day in daysOfWeek.toSet().toList())
        pw.Text(day,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            textAlign: pw.TextAlign.center),
    ];

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(
          base: font,
        ),
        build: (context) {
          return [
            pdfLogo,
            pw.Text('Meal Plan Report',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.TableHelper.fromTextArray(
              headers: tableHeaders,
              cellAlignment: pw.Alignment.center,
              cellPadding:
                  const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              border: pw.TableBorder.all(),
              columnWidths: {
                0: const pw.FlexColumnWidth(2), // Width for the Category column
                for (int i = 1; i <= daysOfWeek.length; i++)
                  i: const pw.FlexColumnWidth(2), // Width for the day columns
              },
              data: [
                [
                  pw.Text(
                    'Number of Children',
                  ),
                  for (final day in daysOfWeek)
                    pw.Text(getNumberOfChildren(plans.values.toList(), day)),
                ],
                for (final category in categories.toSet().toList())
                  [
                    category,
                    ...daysOfWeek.map((day) =>
                        getRecepies(plans.values.toList(), category, day))
                  ],
              ],
            ),
          ];
        },
      ),
    );

    // Save the PDF to a file
    FileSaver.instance.saveFile(
        name: 'meal_plan_${DateTime.now().toIso8601String()}.pdf',
        bytes: await pdf.save());
  }

  int _categoriesOrder(String category) {
    final Map<String, int> categoryOrder = {
      'breakfast': 1,
      'morning tea': 2,
      'lunch': 3,
      'afternoon tea': 4,
      'late snack': 5,
    };

    // Return the order of the given day
    return categoryOrder[category] ?? 0;
  }

  Future<pw.Widget> _getPDFLogo() async {
    var imageFile = await rootBundle.load(Assets.images.appLogoPng.keyName);
    var asUint8List = imageFile.buffer.asUint8List();
    var logoImage = pw.MemoryImage(
      asUint8List,
    );
    return pw.Column(
      children: [
        pw.Center(
          child: pw.Image(logoImage, width: 100, height: 100),
        ),
        pw.SizedBox(height: 10),
      ],
    );
  }

  String getRecepies(
      List<List<MealPlan>>? mealPlans, String category, String day) {
    if (mealPlans != null) {
      List<MealPlan> categoryPlans = [];
      for (List<MealPlan> plans in mealPlans) {
        for (MealPlan mealPlan in plans) {
          if (mealPlan.category == category && mealPlan.day == day) {
            categoryPlans.add(mealPlan);
          }
        }
      }
      if (categoryPlans.isNotEmpty) {
        return categoryPlans
            .map(
                (plan) => plan.recipes?.map((recipe) => recipe.name).join(', '))
            .join('\n');
      }
    }
    return ' - ';
  }

  String getNumberOfChildren(List<List<MealPlan>>? mealPlans, String day) {
    if (mealPlans != null) {
      for (List<MealPlan> plans in mealPlans) {
        for (MealPlan mealPlan in plans) {
          if (mealPlan.day == day) {
            return mealPlan.numberOfChildren.toString();
          }
        }
      }
    }
    return '';
  }
}
