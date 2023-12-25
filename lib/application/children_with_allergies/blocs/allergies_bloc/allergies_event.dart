part of 'allergies_bloc.dart';

@immutable
sealed class AllergiesEvent {}

class GetAllergies extends AllergiesEvent {}

class ToggleAllergies extends AllergiesEvent {
  final AllergicFilter filter;
  ToggleAllergies({
    required this.filter,
  });
}

class ClearSelectedAllergies extends AllergiesEvent {}

class AddOtherAllergy extends AllergiesEvent {
  final List<String> allergies;

  AddOtherAllergy({
    required this.allergies,
  });
}

class ToggleAlreadySelectedAllergies extends AllergiesEvent {
  final List<String> allergies;

  ToggleAlreadySelectedAllergies({required this.allergies});
}
