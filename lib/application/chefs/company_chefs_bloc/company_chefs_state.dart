part of 'company_chefs_bloc.dart';

@immutable
sealed class CompanyChefsState {}

final class CompanyChefsInitial extends CompanyChefsState {}

class LoadingChefs extends CompanyChefsState {}

class CompanyChefsLoaded extends CompanyChefsState {
  final Company company;
  final List<AppUser> chefs;

  CompanyChefsLoaded({required this.company, required this.chefs});
}

class ErrorLoadingCompanyChefs extends CompanyChefsState {
  final String error;

  ErrorLoadingCompanyChefs({required this.error});
}
