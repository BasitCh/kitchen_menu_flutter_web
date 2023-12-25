import 'package:flutter/material.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:widgets_book/widgets_book.dart';

class RegistrationSuccessPage extends StatefulWidget {
  const RegistrationSuccessPage({Key? key}) : super(key: key);

  @override
  State<RegistrationSuccessPage> createState() =>
      _RegistrationSuccessPageState();
}

class _RegistrationSuccessPageState extends State<RegistrationSuccessPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SizedBox(
        width: context.width,
        height: context.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              30.verticalGap,
              Assets.images.appLogoPng.image(height: 184, width: 184),
              120.verticalGap,
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 25.h,
                ),
                child: Assets.icons.accountVerified.svg(),
              ),
              StandardText.subtitle2(context, 'Welcome to menu master',
                  fontSize: 32),
              20.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: StandardText.subtitle2(
                  context,
                  '''
              Welcome to Menu Master. We are excited you are here\nand welcome you to set up your company profile to get\nstarted.
                 ''',
                  color: AppColors.textBlack50,
                  align: TextAlign.center,
                ),
              ),
              28.verticalSpace,
              SizedBox(
                width: context.width / 4,
                child: AppButton.darkRed(
                  child: StandardText.buttonSmall(
                    AppLocalizations.of(context)!
                        .account_created_setup_profile
                        .toUpperCase(),
                  ),
                  onPressed: () {
                    getIt<NavigationService>().replaceWithNamed(
                        context: context,
                        uri: NavigationService.setupCompanyProfileUri);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
