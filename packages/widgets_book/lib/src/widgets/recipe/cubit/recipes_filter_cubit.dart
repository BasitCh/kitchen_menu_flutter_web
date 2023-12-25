import 'package:widgets_book/widgets_book.dart';

class RecipesFilterCubit extends Cubit<List<RecipesFilterState>> {
  RecipesFilterCubit() : super([]);

  List<RecipesFilterState> recipesFilterStateGlobal = [];

  Future<void> getFilters({
    required Map<String, List<String>> filters,
  }) async {
    List<RecipesFilterState> recipesFilterState = <RecipesFilterState>[];
    filters.forEach((key, values) {
      List<FilterState> filtersState = [];
      values.forEach((value) {
        filtersState.add(FilterState(title: value));
      });
      recipesFilterState.add(
        RecipesFilterState(
          title: key,
          filters: filtersState,
        ),
      );
    });
    recipesFilterStateGlobal = recipesFilterState.toList();
    emit(recipesFilterState.toList());
  }

  void updateFiltersWithCheckBox(
      String title, List<FilterState> recipeFilters) {
    final updatedFilters = state.where((element) {
      if (element.title == title) element.copyWith(filters: recipeFilters);
      return true;
    }).toList();
    emit(updatedFilters.toList());
  }

  void updateFilters(List<RecipesFilterState> recipeFilters) {
    // recipeFilters.forEach((recipeFilter) {
    //   print("Title: ${recipeFilter.title}");
    //   recipeFilter.filters.forEach((filter) {
    //     print('${filter.title} ${filter.value}');
    //   });
    // });
    emit(recipeFilters.toList());
  }

  void reset() {
    state.forEach((element) {
      element.filters.forEach((filter) {
        filter.value = false;
        print('Filter name: ${filter.title} ${filter.value}');
      });
    });
    emit(state.toList());
  }
}

