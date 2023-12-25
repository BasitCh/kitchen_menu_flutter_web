import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class RecipeFilterExpandableTile extends StatefulWidget {
  const RecipeFilterExpandableTile({
    Key? key,
    this.title,
    required this.filters,
  }) : super(key: key);

  final String? title;
  final List<FilterState>? filters;

  @override
  State<RecipeFilterExpandableTile> createState() =>
      _RecipeFilterExpandableTileState();
}

class _RecipeFilterExpandableTileState
    extends State<RecipeFilterExpandableTile> {
  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StandardText.headline5(
                context,
                widget.title ??
                    AppLocalizations.of(context)!.create_recipe_allergies,
                fontSize: 16,
                fontWeight: AppFontWeight.bold,
              ),
              if (widget.filters != null)
                ...widget.filters!
                    .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                              activeColor: AppColors.black,
                              value:e.value,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              onChanged: (val) {
                                e.value = val!;
                                widget.filters?.where((element) {
                                  if (element.title == e.title) {
                                    element = e;
                                  }
                                  return true;
                                }).toList();
                                context.read<RecipesFilterCubit>().updateFiltersWithCheckBox(
                                    widget.title ?? '', widget.filters ?? [],);
                              },),
                          StandardText.subtitle2(context, e.title),
                          5.horizontalSpace,
                        ],
                      ),
                    ))
                    .toList()

              // if (widget.filters != null)
              //   ...widget.filters!
              //       .map((e) => buildCheckBoxListTile(e, context))
              //       .toList(),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StandardText.headline5(
                    context,
                    widget.title ??
                        AppLocalizations.of(context)!.create_recipe_allergies,
                    fontSize: 16,
                    fontWeight: AppFontWeight.bold,
                  ),
                  const Icon(
                    Icons.keyboard_arrow_up,
                  )
                ],
              ),
              8.verticalSpace,
              if (widget.filters != null)
                ...widget.filters!
                    .map((e) => buildCheckBoxListTile(e, context))
                    .toList(),
              10.verticalSpace,
              const Divider(
                color: AppColors.grey100,
              ),
              30.verticalSpace,
            ],
          );
  }

  Widget buildCheckBoxListTile(FilterState filterState, BuildContext context) {
    return ListTileTheme(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      minVerticalPadding: 0,
      dense: true,
      child: CheckboxListTile(
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        side: const BorderSide(width: .5),
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        title: StandardText.subtitle2(context, filterState.title),
        value: filterState.value,
        activeColor: AppColors.black,
        onChanged: (val) {
          filterState.value = val!;
          widget.filters?.where((element) {
            if (element.title == filterState.title) {
              element = filterState;
            }
            return true;
          }).toList();
          context.read<RecipesFilterCubit>().updateFiltersWithCheckBox(
              widget.title ?? '', widget.filters ?? []);
        },
      ),
    );
  }
}
