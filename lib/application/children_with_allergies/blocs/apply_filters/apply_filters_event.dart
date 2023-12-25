part of 'apply_filters_bloc.dart';

@immutable
abstract class ApplyFiltersEvent {}

class ApplyFilters extends ApplyFiltersEvent {
  final List<AllergicFilter>? selectedFilters;
  final List<Day>? selectedDays;
  ApplyFilters({
    this.selectedFilters,
    this.selectedDays,
  });
}

class ClearSelectedFilter extends ApplyFiltersEvent {
  final AllergicFilter selectedFilter;
  ClearSelectedFilter({required this.selectedFilter});
}

class ClearSelectedDay extends ApplyFiltersEvent {
  final Day selectedDay;
  ClearSelectedDay({required this.selectedDay});
}

class ClearAppliedFilters extends ApplyFiltersEvent {}
