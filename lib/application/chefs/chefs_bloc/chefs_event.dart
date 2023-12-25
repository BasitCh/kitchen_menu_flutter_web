part of 'chefs_bloc.dart';

@immutable
sealed class ChefsEvent {}

class GetCompany extends ChefsEvent {
}

class GetCompanyChefs extends ChefsEvent {
  final Company company;
  GetCompanyChefs({
    required this.company,
  });
}
