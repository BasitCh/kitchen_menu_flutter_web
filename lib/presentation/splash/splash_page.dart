import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/splash/splash_bloc/splash_bloc.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/presentation/splash/widgets/splash_loading.dart';
import 'package:widgets_book/widgets_book.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoadedState) {
          getIt<NavigationService>().replaceWithNamed(
            context: context,
            uri: NavigationService.loginRouteUri,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.accent,
        body: SizedBox(
          width: context.width,
          height: context.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.icons.splashLogoWeb.image(),
              70.verticalSpace,
              const SplashLoading(),
            ],
          ),
        ),
      ),
    );
  }
}
