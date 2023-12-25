

class RecipesFilterState {
  RecipesFilterState({
    required this.title,
    required this.filters,
  });

  final String title;
  final List<FilterState> filters;

  RecipesFilterState copyWith({
    String? title,
    List<FilterState>? filters,
  }) =>
      RecipesFilterState(
        title: title ?? this.title,
        filters: filters ?? this.filters,
      );
}

class FilterState {
  FilterState({
    required this.title,
    this.value = false,
  });

  final String title;
  bool value;
}
