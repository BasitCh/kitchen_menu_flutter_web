import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/chefs/company_chefs_bloc/company_chefs_bloc.dart';
import 'package:menumaster_manager/presentation/chefs/widgets/chef_item.dart';
import 'package:menumaster_manager/presentation/widgets/app_bar.dart';
import 'package:widgets_book/widgets_book.dart';

class CompanyChefsPage extends StatefulWidget {
  const CompanyChefsPage({super.key});

  @override
  State<CompanyChefsPage> createState() => _CompanyChefsPageState();
}

class _CompanyChefsPageState extends State<CompanyChefsPage> {
  @override
  void initState() {
    super.initState();
    this.context.read<CompanyChefsBloc>().add(
          GetCompany(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBar: const ManagerBar(),
        appBarHeight: 80,
        body: BlocBuilder<CompanyChefsBloc, CompanyChefsState>(builder: (context, state) {
          return state is LoadingChefs
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.accent,
                  ),
                )
              : state is ErrorLoadingCompanyChefs
                  ? Center(
                      child: StandardText.headline1(context, state.error,
                          color: AppColors.gray),
                    )
                  : (state is CompanyChefsLoaded)
                      ? state.chefs.isEmpty
                          ? Center(
                              child: StandardText.headline1(
                                  context, 'No chef found',
                                  color: AppColors.gray),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: ListView.builder(
                                itemCount: state.chefs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return ChefItem(
                                    showDeleteIcon: false,
                                    user: state.chefs[index],
                                  );
                                },
                              ),
                            )
                      : const SizedBox.shrink();
        }));
  }
}
