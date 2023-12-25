part of 'chefs_bloc.dart';

@immutable
sealed class ChefsState {}

final class ChefsInitial extends ChefsState {}

class LoadingChefs extends ChefsState {}

class CompanyChefsLoaded extends ChefsState {
  final Company company;
  final List<AppUser> chefs;

  CompanyChefsLoaded({required this.company, required this.chefs});
}

class ErrorLoadingCompanyChefs extends ChefsState {
  final String error;

  ErrorLoadingCompanyChefs({required this.error});
}
