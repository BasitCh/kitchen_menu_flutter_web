import 'package:widgets_book/widgets_book.dart';


class RecipesAppliedFiltersCubit extends Cubit<List<FilterState>> {
  RecipesAppliedFiltersCubit() : super([]);

  void updateAppliedFilters(List<FilterState> filtersState) {
    emit(filtersState);
  }

  void removeAppliedFilter(FilterState filterState) {
    List<FilterState> tempList = state;
    tempList.remove(filterState);
    reset();
    updateAppliedFilters(tempList);
  }

  void reset() {
    emit([]);
  }
}
