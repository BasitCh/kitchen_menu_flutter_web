import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/profile/manager_profile_bloc/manager_profile_bloc.dart';
import 'package:menumaster_manager/presentation/profile/widgets/company_details.dart';
import 'package:menumaster_manager/presentation/profile/widgets/manager_details.dart';
import 'package:menumaster_manager/presentation/widgets/app_bar.dart';
import 'package:widgets_book/widgets_book.dart';

class ManagerProfilePage extends StatefulWidget {
  const ManagerProfilePage({super.key});

  @override
  State<ManagerProfilePage> createState() => _ManagerProfilePageState();
}

class _ManagerProfilePageState extends State<ManagerProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
        appBar: ManagerBar(), appBarHeight: 80, body: ManagerProfileUi());
  }
}

class ManagerProfileUi extends StatefulWidget {
  const ManagerProfileUi({super.key});

  @override
  State<ManagerProfileUi> createState() => _ManagerProfileUiState();
}

class _ManagerProfileUiState extends State<ManagerProfileUi> {
  @override
  void initState() {
    super.initState();
     this.context.read<ManagerProfileBloc>().add(GetUser());
  }

  @override
  Widget build(BuildContext context) {
   
    return BlocConsumer<ManagerProfileBloc, ManagerProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is LoadingUser || state is LoadingCompany
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : state is CompanyLoaded
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ListView(
                      children: [
                        20.verticalGap,
                        ManagerDetails(user: state.appUser),
                        20.verticalGap,
                        CompanyDetails(company: state.company),
                      ],
                    ),
                  )
                : state is ErrorLoadingUser || state is ErrorLoadingCompany
                    ? Center(
                        child: StandardText.body2(
                            context, 'Error fetching detailse'),
                      )
                    : const SizedBox.shrink();
      },
    );
  }
}
