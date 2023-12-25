part of 'filters_bloc.dart';

@immutable
abstract class FiltersEvent {}

class GetFilters extends FiltersEvent {}

class ToggleFilter extends FiltersEvent {
  final AllergicFilter filter;
  ToggleFilter({
    required this.filter,
  });
}

class ClearFilters extends FiltersEvent {}