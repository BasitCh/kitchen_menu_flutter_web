import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/login/cubits/login_cubit.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/presentation/login/login_form.dart';
import 'package:widgets_book/widgets_book.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController email;
  late TextEditingController password;
  Toasts toasts = Toasts();
  @override
  void initState() {
    email = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Center(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => LoginCubit(),
            ),
          ],
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Assets.images.appLogoPng.image(height: 184, width: 184),
                20.verticalGap,
                StandardText.headline3(
                  context,
                  'Login',
                  fontWeight: FontWeight.w300,
                  fontSize: 44,
                  color: AppColors.textBlack80,
                  align: TextAlign.center,
                ),
                10.verticalGap,
                StandardText.headline1(
                  context,
                  'Email and Password to login',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  fontFamily: Assets.fonts.poppinsRegular,
                  color: AppColors.textBlack60,
                  align: TextAlign.center,
                ),
                GestureDetector(
                  onTap: () {
                    getIt<NavigationService>().replaceWithNamed(
                      context: context,
                      uri: NavigationService.signupRouteUri,
                    );
                  },
                  child: StandardText.underline(
                    context,
                    'Don\'t have account? Create Now',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.black,
                    align: TextAlign.center,
                  ),
                ),
                LoginForm(
                  email: email,
                  password: password,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
