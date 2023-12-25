// ignore_for_file: depend_on_referenced_packages
import 'package:menumaster_manager/domain/children_with_allergies/allergic_filter.dart';
import 'package:menumaster_manager/infrastructure/children_with_allergies/filters_repository.dart';
import 'package:meta/meta.dart';
import 'package:widgets_book/widgets_book.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  List<AllergicFilter> localFilters = [];
  final FiltersRepository filtersRepository;

  FiltersBloc({required this.filtersRepository}) : super(FiltersInitial()) {
    on<GetFilters>(_onGetFilters);
    on<ToggleFilter>(_onToggleFilter);
    on<ClearFilters>(_onClearFilter);
  }

  Future<void> _onGetFilters(
    GetFilters event,
    Emitter<FiltersState> emit,
  ) async {
    final response = await filtersRepository.getAllergies();

    response.fold(
        (ApiError apiError) => emit(
              ErrorFetchingFilters(
                error: apiError.message ?? 'Error getting filters',
              ),
            ), (filters) {
      localFilters.clear();
      for (var element in filters.data!.values) {
        for (var filter in element) {
          localFilters.add(AllergicFilter(name: filter));
        }
      }
      emit(
        FiltersFetched(
          filters: localFilters,
        ),
      );
    });
  }

  Future<void> _onToggleFilter(
    ToggleFilter event,
    Emitter<FiltersState> emit,
  ) async {
    final index = localFilters.indexOf(event.filter);

    localFilters[index] = AllergicFilter(
        name: localFilters[index].name,
        isSelected: !localFilters[index].isSelected!);
    emit(
      FiltersFetched(filters: localFilters),
    );
  }

  Future<void> _onClearFilter(
    ClearFilters event,
    Emitter<FiltersState> emit,
  ) async {
    for (var filter in localFilters) {
      filter.isSelected = false;
    }
    emit(
      FiltersFetched(filters: localFilters),
    );
  }
}
