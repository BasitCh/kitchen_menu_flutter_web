import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/allergies_bloc/allergies_bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/attendance_bloc/attendance_bloc.dart';
import 'package:menumaster_manager/domain/children_with_allergies/child.dart';
import 'package:menumaster_manager/presentation/children_with_allergies/add_child_item.dart';
import 'package:menumaster_manager/presentation/widgets/app_bar.dart';
import 'package:widgets_book/widgets_book.dart';

class AddChildPage extends StatefulWidget {
  const AddChildPage({super.key, this.child});

  final Child? child;

  @override
  State<AddChildPage> createState() => _AddChildPageState();
}

class _AddChildPageState extends State<AddChildPage> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBarHeight: 80,
      appBar: const ManagerBar(),
      body: AddChildUI(
        child: widget.child,
      ),
    );
  }
}

class AddChildUI extends StatefulWidget {
  const AddChildUI({super.key, this.child});

  final Child? child;

  @override
  State<AddChildUI> createState() => _AddChildUIState();
}

class _AddChildUIState extends State<AddChildUI> {
  @override
  void initState() {
    super.initState();
    this.context.read<AllergiesBloc>().add(GetAllergies());
    this.context.read<AttendanceBloc>().add(GetWeekDays(child: widget.child));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.verticalGap,
            StandardText.headline1(
              context,
              'ADD A CHILD',
              fontFamily: Assets.fonts.yugothicLight,
              fontSize: 40,
              fontWeight: FontWeight.w300,
              color: AppColors.textBlack80,
              align: TextAlign.start,
            ),
            5.verticalGap,
            StandardText.body2(
                context, 'Fill out the form fields below to add a child.',
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: AppColors.textBlack),
            30.verticalGap,
            AddChildItem(
              child: widget.child,
            ),
            30.verticalSpace,
          ],
        ),
      ),
    );
  }
}
