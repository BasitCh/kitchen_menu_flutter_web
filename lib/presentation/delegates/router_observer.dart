import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/presentation/delegates/gorouter_delegate.dart';

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      print('Pushed route: ${route.str}');
    }
    bool isForgotPasswordRoute =
        route.settings.name == NavigationService.forgotPasswordUri;
    bool isSplashRoute =
        route.settings.name == NavigationService.splashRouteUri;
    bool isSignupRoute =
        route.settings.name == NavigationService.signupRouteUri;
    bool isSetupProfileUri =
        route.settings.name == NavigationService.setupProfileUri;
    bool isSetupCompanyUri =
        route.settings.name == NavigationService.setupCompanyProfileUri;
    bool isRegistrationSuccess =
        route.settings.name == NavigationService.registrationSuccessUri;

    if (isForgotPasswordRoute ||
        isSignupRoute ||
        isSplashRoute ||
        isSetupProfileUri ||
        isSetupCompanyUri ||
        isRegistrationSuccess) {
    } else {
      if (firebaseAuth.currentUser == null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          getIt<NavigationService>().replaceWithNamed(
              context: rootNavigatorKey.currentContext!,
              uri: NavigationService.loginRouteUri);
        });
      }
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      print('didPop route: ${route.str}');
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (kDebugMode) {
      print('Removed route: ${route.str}');
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (kDebugMode) {
      print('Replaced newRoute: ${newRoute!.str}');
    }
  }
}

extension on Route<dynamic> {
  String get str => 'route(${settings.name}: ${settings.arguments})';
}
