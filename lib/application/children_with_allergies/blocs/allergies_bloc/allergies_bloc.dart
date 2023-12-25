// ignore_for_file: depend_on_referenced_packages

import 'package:menumaster_manager/domain/children_with_allergies/allergic_filter.dart';
import 'package:menumaster_manager/infrastructure/children_with_allergies/filters_repository.dart';
import 'package:meta/meta.dart';
import 'package:widgets_book/widgets_book.dart';

part 'allergies_event.dart';
part 'allergies_state.dart';

class AllergiesBloc extends Bloc<AllergiesEvent, AllergiesState> {
  final List<AllergicFilter> localFilters = [];
  final FiltersRepository filtersRepository;

  AllergiesBloc({required this.filtersRepository}) : super(AllergiesInitial()) {
    on<GetAllergies>(_onGetAllergies);
    on<ToggleAllergies>(_onToggleAllergies);
    // on<ClearSelectedAllergies>(_onClearAppliedAllergies);
    on<AddOtherAllergy>(_onAddAllergy);
    on<ToggleAlreadySelectedAllergies>(_onToggleAlreadySelectedAllergies);
  }

  Future<void> _onGetAllergies(
    GetAllergies event,
    Emitter<AllergiesState> emit,
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
      localFilters.add(
        AllergicFilter(name: 'Other', isSelected: false),
      );
      emit(
        AllergiesFetched(
          allergies: localFilters,
        ),
      );
    });
  }

  Future<void> _onToggleAllergies(
    ToggleAllergies event,
    Emitter<AllergiesState> emit,
  ) async {
    final index = localFilters.indexOf(event.filter);

    localFilters[index] = AllergicFilter(
        name: localFilters[index].name,
        isSelected: !localFilters[index].isSelected!);
    emit(
      AllergiesToggled(allergies: localFilters),
    );
  }

  Future<void> _onClearAppliedAllergies(
    ClearSelectedAllergies event,
    Emitter<AllergiesState> emit,
  ) async {
    for (AllergicFilter allergicFilter in localFilters) {
      allergicFilter.isSelected = false;
    }
    emit(
      AllergiesFetched(allergies: localFilters),
    );
  }

  Future<void> _onAddAllergy(
    AddOtherAllergy event,
    Emitter<AllergiesState> emit,
  ) async {
    try {
      await filtersRepository.addAllergy(
        allergies: event.allergies,
      );
      emit(AllergyAdded());
    } catch (e) {
      emit(
        ErrorAddingAllergy(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onToggleAlreadySelectedAllergies(
    ToggleAlreadySelectedAllergies event,
    Emitter<AllergiesState> emit,
  ) async {
    for (String allergy in event.allergies) {
      localFilters.firstWhere((element) => element.name == allergy).isSelected =
          true;
    }
    emit(
      AllergiesToggledForOldChild(allergies: localFilters),
    );
  }
}
