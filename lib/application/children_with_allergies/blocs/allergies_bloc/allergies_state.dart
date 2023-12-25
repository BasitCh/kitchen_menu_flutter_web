part of 'allergies_bloc.dart';

@immutable
sealed class AllergiesState {}

final class AllergiesInitial extends AllergiesState {}

class AllergiesFetched extends AllergiesState {
  final List<AllergicFilter> allergies;

  AllergiesFetched({required this.allergies});
}

class AllergiesToggled extends AllergiesState {
   final List<AllergicFilter> allergies;

  AllergiesToggled({required this.allergies});
}

class AllergiesToggledForOldChild extends AllergiesState {
  final List<AllergicFilter> allergies;
  AllergiesToggledForOldChild({required this.allergies});
}

class ErrorFetchingFilters extends AllergiesState {
  final String error;
  ErrorFetchingFilters({required this.error});
}

class AllergyAdded extends AllergiesState {}

class ErrorAddingAllergy extends AllergiesState {
  final String error;

  ErrorAddingAllergy({
    required this.error,
  });
}
