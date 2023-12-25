part of 'manager_profile_bloc.dart';

@immutable
sealed class ManagerProfileState {}

final class ManagerProfileInitial extends ManagerProfileState {}

class LoadingUser extends ManagerProfileState {}

class UserLoaded extends ManagerProfileState {
  final AppUser? user;

  UserLoaded({required this.user});
}

class ErrorLoadingUser extends ManagerProfileState {
  final String error;

  ErrorLoadingUser({
    required this.error,
  });
}

class LoadingCompany extends ManagerProfileState {}

class CompanyLoaded extends ManagerProfileState {
  final AppUser appUser;
  final Company company;

  CompanyLoaded({
    required this.appUser,
    required this.company,
  });
}

class ErrorLoadingCompany extends ManagerProfileState {
  final String error;

  ErrorLoadingCompany({
    required this.error,
  });
}
