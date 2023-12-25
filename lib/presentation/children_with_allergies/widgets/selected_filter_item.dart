import 'package:flutter/material.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/apply_filters/apply_filters_bloc.dart';
import 'package:menumaster_manager/domain/children_with_allergies/allergic_filter.dart';
import 'package:widgets_book/widgets_book.dart';

class SelectedFilterItem extends StatelessWidget {
  const SelectedFilterItem({required this.filter, super.key});
  final AllergicFilter filter;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      margin: const EdgeInsets.only(
        right: 4,
        top: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColors.charcoal,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          StandardText.subtitle3(
            context,
            filter.name,
            color: AppColors.white,
          ),
          4.horizontalSpace,
          InkWell(
            onTap: () {
              context.read<ApplyFiltersBloc>().add(ClearSelectedFilter(selectedFilter: filter));
            },
            child: const Icon(
              Icons.close,
              color: AppColors.white,
              size: 12,
            ),
          )
        ],
      ),
    );
  }
}
