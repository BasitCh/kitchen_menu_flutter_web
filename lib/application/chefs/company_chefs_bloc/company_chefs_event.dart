part of 'company_chefs_bloc.dart';

@immutable
sealed class CompanyChefsEvent {}

class GetCompany extends CompanyChefsEvent {}

class GetActiveCompanyChefs extends CompanyChefsEvent {
  final Company company;

  GetActiveCompanyChefs({
    required this.company,
  });
}