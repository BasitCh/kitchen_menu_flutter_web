import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/chefs/chefs_bloc/chefs_bloc.dart';
import 'package:menumaster_manager/application/main/cubit/main_navbar_cubit.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/navigation_service.dart';
import 'package:menumaster_manager/presentation/chefs/widgets/chef_item.dart';
import 'package:menumaster_manager/presentation/chefs/widgets/company_details_item.dart';
import 'package:menumaster_manager/presentation/widgets/app_bar.dart';
import 'package:widgets_book/widgets_book.dart';

class ChefsPage extends StatefulWidget {
  const ChefsPage({super.key});

  @override
  State<ChefsPage> createState() => _ChefsPageState();
}

class _ChefsPageState extends State<ChefsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      appBarHeight: 80,
      appBar: ManagerBar(),
      body: ChefsPageUI(),
    );
  }
}

class ChefsPageUI extends StatefulWidget {
  const ChefsPageUI({
    super.key,
  });

  @override
  State<ChefsPageUI> createState() => _ChefsPageUIState();
}

class _ChefsPageUIState extends State<ChefsPageUI> {
  @override
  void initState() {
    super.initState();
    this.context.read<ChefsBloc>().add(GetCompany());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChefsBloc, ChefsState>(
      builder: (context, state) {
        return state is LoadingChefs
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.accent,
                ),
              )
            : state is CompanyChefsLoaded
                ? SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(left: 40, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          30.verticalGap,
                          CompanyDetailsItem(
                            company: state.company,
                            chefsLenth: state.chefs.length,
                          ),
                          50.verticalGap,
                          StandardText.headline1(
                            context,
                            'CHEFS IN COMPANY',
                            fontSize: 22,
                            color: AppColors.textBlack80,
                            fontWeight: FontWeight.w700,
                          ),
                          30.verticalGap,
                          ListView.builder(
                            itemCount: state.chefs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ChefItem(
                                user: state.chefs[index],
                              );
                            },
                          ),
                          30.verticalGap,
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              width: kIsWeb
                                  ? context.width / 5
                                  : context.width / 3,
                              child: AppButton.darkRed(
                                onPressed: () {
                                  context
                                      .read<MainNavBarCubit>()
                                      .changeDrawerNavBar(1);
                                  getIt<NavigationService>().replaceWithNamed(
                                      context: context,
                                      uri: NavigationService.inviteChefsUri);
                                },
                                radius: 8,
                                child: StandardText.buttonLarge(
                                  'SEND INVITE',
                                ),
                              ),
                            ),
                          ),
                          20.verticalSpace,
                        ],
                      ),
                    ),
                  )
                : state is ErrorLoadingCompanyChefs
                    ? Center(
                        child: StandardText.headline4(
                          context,
                          state.error,
                          color: AppColors.accent,
                        ),
                      )
                    : const SizedBox.shrink();
      },
    );
  }
}
