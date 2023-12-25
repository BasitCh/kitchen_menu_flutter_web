import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/get_children_bloc/get_children_bloc.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/widgets/children_with_allergies_ui.dart';
import 'package:menumaster_manager/presentation/widgets/app_bar.dart';
import 'package:widgets_book/widgets_book.dart';

class ChildrenWithAllergiesPage extends StatefulWidget {
  const ChildrenWithAllergiesPage({super.key});

  @override
  State<ChildrenWithAllergiesPage> createState() =>
      _ChildrenWithAllergiesPageState();
}

class _ChildrenWithAllergiesPageState extends State<ChildrenWithAllergiesPage> {
  @override
  void initState() {
    super.initState();
    this.context.read<GetChildrenBloc>().add(GetChildren());
  }

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
        appBar: ManagerBar(),
        appBarHeight: 80,
        body: ChildrenWithAllergiesUI());
  }
}
