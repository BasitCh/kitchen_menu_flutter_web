// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:menumaster_manager/application/children_with_allergies/blocs/attendance_bloc/attendance_bloc.dart';
import 'package:menumaster_manager/domain/children_with_allergies/allergic_filter.dart';
import 'package:meta/meta.dart';

part 'apply_filters_event.dart';
part 'apply_filters_state.dart';

class ApplyFiltersBloc extends Bloc<ApplyFiltersEvent, ApplyFiltersState> {
  List<AllergicFilter> selectedFilters = [];
  List<Day> selectedDays = [];

  ApplyFiltersBloc() : super(ApplyFiltersInitial()) {
    on<ApplyFilters>(_onApplyFilters);
    on<ClearSelectedFilter>(_onTogleFilter);
    on<ClearSelectedDay>(_onToggleDay);
    on<ClearAppliedFilters>(_onClearAppliedFilters);
  }

  Future<void> _onApplyFilters(
    ApplyFilters event,
    Emitter<ApplyFiltersState> emit,
  ) async {
    selectedFilters = event.selectedFilters ?? [];
    selectedDays = event.selectedDays ?? [];
    emit(
      AppliedFilters(filters: selectedFilters, selectedDays: selectedDays),
    );
  }

  Future<void> _onTogleFilter(
    ClearSelectedFilter event,
    Emitter<ApplyFiltersState> emit,
  ) async {
    selectedFilters.remove(event.selectedFilter);
    emit(
      AppliedFilters(filters: selectedFilters, selectedDays: selectedDays),
    );
  }

  Future<void> _onToggleDay(
    ClearSelectedDay event,
    Emitter<ApplyFiltersState> emit,
  ) async {
    selectedDays.remove(event.selectedDay);
    emit(
      AppliedFilters(selectedDays: selectedDays, filters: selectedFilters),
    );
  }

  Future<void> _onClearAppliedFilters(
    ClearAppliedFilters event,
    Emitter<ApplyFiltersState> emit,
  ) async {
    emit(
      AppliedFilters(filters: const [], selectedDays: const []),
    );
  }
}
