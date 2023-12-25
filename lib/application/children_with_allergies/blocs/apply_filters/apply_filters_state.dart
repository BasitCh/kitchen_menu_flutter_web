part of 'apply_filters_bloc.dart';

@immutable
abstract class ApplyFiltersState {}

class ApplyFiltersInitial extends ApplyFiltersState {}

class AppliedFilters extends ApplyFiltersState {
  final List<AllergicFilter>? filters;
  final List<Day>? selectedDays;
  AppliedFilters({
     this.filters,
     this.selectedDays,
  });
}
