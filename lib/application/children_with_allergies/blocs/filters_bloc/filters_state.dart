part of 'filters_bloc.dart';

@immutable
abstract class FiltersState {}

class FiltersInitial extends FiltersState {}

class FiltersFetched extends FiltersState {
  final List<AllergicFilter> filters;

  FiltersFetched({required this.filters});
}

class ErrorFetchingFilters extends FiltersState {
  final String error;
  ErrorFetchingFilters({required this.error});
}
