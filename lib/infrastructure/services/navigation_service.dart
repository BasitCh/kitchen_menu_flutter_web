// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:widgets_book/widgets_book.dart';

class Singleton {
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();
}

abstract class NavigationService {
  static const String splashRouteUri = '/';
  static const String loginRouteUri = 'login';
  static const String setupProfileUri = 'setup_profile';
  static const String setupCompanyProfileUri = 'company_profile';
  static const String signupRouteUri = 'signup';
  static const String registrationSuccessUri = 'registration_success';
  static const String forgotPasswordUri = 'forgot_password';
  static const String dashBoardUri = 'dashboard';
  static const String chefsUri = 'chefs';
  static const String inviteChefsUri = 'invite_chefs';
  static const String mealPlansUri = 'meal_plans';
  static const String shoppingListUri = 'shopping_list';
  static const String recipeDetailsUri = 'recipe_details';
  static const String childrenWithAllergiesUri = '/children_with_allergies';
  static const String addChildUri = 'add_child';
  static const String managerProfileUri = 'manager_profile';
  static const String checkoutSuccessUri = 'checkout_success';
  static const String companyChefsUri = '/company_chefs';

  void navigateToNamed({
    required BuildContext context,
    required String uri,
    Object? data,
  });

  void replaceWithNamed({
    required BuildContext context,
    required String uri,
    Object? data,
  });

  void showSnackbar({
    required String message,
    bool isError = false,
    Color backgroundColor = AppColors.white,
  });

  void navigateBack({required BuildContext context});

  Future<void> launchUrl({
    required String urlString,
    required bool external,
  });

//String? get currentRouteUriString;
}

class GoRouterNavigationService extends NavigationService
    with NavigationServiceMixins {
  GoRouterNavigationService();

  @override
  void navigateToNamed({
    required BuildContext context,
    required String uri,
    Object? data,
  }) =>
      context.pushNamed(
        uri,
        extra: data,
      );

  @override
  void showSnackbar({
    required String message,
    bool isError = false,
    Color backgroundColor = AppColors.white,
    Color textColor = AppColors.primary,
  }) =>
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: isError ? AppColors.white : backgroundColor,
        textColor: isError ? AppColors.primary : textColor,
        fontSize: 16.0,
      );

  @override
  void replaceWithNamed({
    required BuildContext context,
    required String uri,
    Object? data,
    Map<String, String>? pathParameters,
  }) =>
      Router.neglect(context, () {
        context.goNamed(uri, extra: data);
      });

  @override
  void navigateBack({required BuildContext context}) => context.pop();
}

mixin NavigationServiceMixins implements NavigationService {
  @override
  Future<void> launchUrl({
    required String urlString,
    required bool external,
  }) async {
    if (await launcher.canLaunchUrl(Uri.parse(urlString))) {
      await launcher.launchUrl(
        Uri.parse(urlString),
        mode: external
            ? launcher.LaunchMode.externalApplication
            : launcher.LaunchMode.inAppWebView,
        webViewConfiguration: const launcher.WebViewConfiguration(),
      );
    }
  }
}
