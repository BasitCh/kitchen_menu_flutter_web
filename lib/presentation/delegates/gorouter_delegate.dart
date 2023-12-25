// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/main/cubit/main_navbar_cubit.dart';
import 'package:menumaster_manager/domain/children_with_allergies/child.dart';
import 'package:menumaster_manager/domain/profile/company.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/presentation/chefs/chefs_page.dart';
import 'package:menumaster_manager/presentation/chefs/dashboard_page.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/add_child_page.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/children_with_allergies_page.dart';
import 'package:menumaster_manager/presentation/delegates/router_observer.dart';
import 'package:menumaster_manager/presentation/forgot_password/forgot_password_page.dart';
import 'package:menumaster_manager/presentation/home/home_page.dart';
import 'package:menumaster_manager/presentation/invite_chefs/invite_chefs_page.dart';
import 'package:menumaster_manager/presentation/invite_chefs/widgets/checkout_success_page.dart';
import 'package:menumaster_manager/presentation/login/login_page.dart';
import 'package:menumaster_manager/presentation/meal_plans/company_chefs_page.dart';
import 'package:menumaster_manager/presentation/meal_plans/meal_plans_page.dart';
import 'package:menumaster_manager/presentation/meal_plans/recipe_details_page.dart';
import 'package:menumaster_manager/presentation/meal_plans/shopping_list_page.dart';
import 'package:menumaster_manager/presentation/profile/company_profile_page.dart';
import 'package:menumaster_manager/presentation/profile/manager_profile_page.dart';
import 'package:menumaster_manager/presentation/profile/setup_profile_page.dart';
import 'package:menumaster_manager/presentation/signup/registration_success_page.dart';
import 'package:menumaster_manager/presentation/signup/signup_page.dart';
import 'package:menumaster_manager/presentation/splash/splash_page.dart';
import 'package:widgets_book/widgets_book.dart';

import '../../infrastructure/services/navigation_service.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _dashBoardShellNavigatorKey =
    GlobalKey<NavigatorState>();

class GoRouterDelegate {
  static final GoRouter routerConfig = GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: NavigationService.splashRouteUri,
      observers: [GoRouterObserver()],
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: NavigationService.splashRouteUri,
          builder: (context, routerState) {
            return const SplashPage();
          },
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: '/${NavigationService.loginRouteUri}',
          name: NavigationService.loginRouteUri,
          builder: (context, routerState) => const LoginPage(),
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: '/${NavigationService.signupRouteUri}',
          name: NavigationService.signupRouteUri,
          builder: (context, routerState) {
            return const SignupPage();
          },
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: '/${NavigationService.setupProfileUri}',
          name: NavigationService.setupProfileUri,
          builder: (context, routerState) {
            return SetupProfilePage(
              user: routerState.extra != null
                  ? routerState.extra as AppUser
                  : null,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: '/${NavigationService.setupCompanyProfileUri}',
          name: NavigationService.setupCompanyProfileUri,
          builder: (context, routerState) {
            return CompanyProfilePage(
              company: routerState.extra != null
                  ? routerState.extra as Company
                  : null,
            );
          },
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: '/${NavigationService.registrationSuccessUri}',
          name: NavigationService.registrationSuccessUri,
          builder: (context, routerState) {
            return const RegistrationSuccessPage();
          },
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: '/${NavigationService.forgotPasswordUri}',
          name: NavigationService.forgotPasswordUri,
          builder: (context, routerState) {
            return const ForgotPasswordPage();
          },
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return BlocProvider(
              create: (context) => MainNavBarCubit(),
              child: Homepage(navigationShell: navigationShell),
            );
          },
          branches: <StatefulShellBranch>[
            StatefulShellBranch(
              navigatorKey: _dashBoardShellNavigatorKey,
              routes: [
                GoRoute(
                  path: '/${NavigationService.dashBoardUri}',
                  name: NavigationService.dashBoardUri,
                  pageBuilder: (context, routerState) =>
                      const NoTransitionPage(child: DashBoardPage()),
                  routes: <RouteBase>[
                    GoRoute(
                      path: NavigationService.chefsUri,
                      name: NavigationService.chefsUri,
                      pageBuilder: (context, routerState) =>
                          const NoTransitionPage(child: ChefsPage()),
                    ),
                  ],
                ),
              ],
            ),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/${NavigationService.managerProfileUri}',
                name: NavigationService.managerProfileUri,
                pageBuilder: (context, routerState) =>
                    const NoTransitionPage(child: ManagerProfilePage()),
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/${NavigationService.inviteChefsUri}',
                name: NavigationService.inviteChefsUri,
                pageBuilder: (context, routerState) =>
                    const NoTransitionPage(child: InviteChefsPage()),
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(
                  path: '/${NavigationService.mealPlansUri}',
                  name: NavigationService.mealPlansUri,
                  pageBuilder: (context, routerState) {
                    return NoTransitionPage(
                        child: MealPlansPage(
                      userId: routerState.extra != null
                          ? routerState.extra as String
                          : null,
                    ));
                  },
                  routes: [
                    GoRoute(
                        path: NavigationService.recipeDetailsUri,
                        name: NavigationService.recipeDetailsUri,
                        pageBuilder: (context, routerState) {
                          return NoTransitionPage(
                              child: RecipeDetailPage(
                            recipeId: routerState.extra != null
                                ? routerState.extra as String
                                : null,
                          ));
                        }),
                    GoRoute(
                        path: NavigationService.shoppingListUri,
                        name: NavigationService.shoppingListUri,
                        pageBuilder: (context, routerState) {
                          return const NoTransitionPage(
                              child: MealPlanShoppingListPage());
                        }),
                  ]),
            ]),
            StatefulShellBranch(
              routes: [
                GoRoute(
                    path: NavigationService.childrenWithAllergiesUri,
                    name: NavigationService.childrenWithAllergiesUri,
                    pageBuilder: (context, routerState) =>
                        const NoTransitionPage(
                            child: ChildrenWithAllergiesPage()),
                    routes: <RouteBase>[
                      GoRoute(
                        path: NavigationService.addChildUri,
                        name: NavigationService.addChildUri,
                        pageBuilder: (context, routerState) => NoTransitionPage(
                          child: AddChildPage(
                            child: routerState.extra != null
                                ? routerState.extra as Child
                                : null,
                          ),
                        ),
                      ),
                    ]),
              ],
            ),
            StatefulShellBranch(routes: [
              GoRoute(
                path: NavigationService.companyChefsUri,
                name: NavigationService.companyChefsUri,
                pageBuilder: (context, routerState) =>
                    const NoTransitionPage(child: CompanyChefsPage()),
              ),
            ]),
          ],
        ),
        GoRoute(
          parentNavigatorKey: rootNavigatorKey,
          path: '/${NavigationService.checkoutSuccessUri}',
          name: NavigationService.checkoutSuccessUri,
          builder: (context, routerState) {
            return const CheckOutSuccessPage();
          },
        ),
      ]);
}
