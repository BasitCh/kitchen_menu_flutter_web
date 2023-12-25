part of 'get_children_bloc.dart';

@immutable
sealed class GetChildrenEvent {}

class GetChildren extends GetChildrenEvent {}

class GetFilteredChildren extends GetChildrenEvent {
  final List<AllergicFilter>? selectedFilters;
  final List<Day>? selectedDays;

  GetFilteredChildren({ this.selectedFilters,  this.selectedDays});
}

class RestoreLocalChildren extends GetChildrenEvent {}
