part of 'setup_profile_bloc.dart';

@immutable
sealed class SetupProfileState {}

final class SetupProfileInitial extends SetupProfileState {}

class UpdatingProfile extends SetupProfileState {}

class ProfileUpdated extends SetupProfileState {
  ProfileUpdated({
    required this.appUser,
    this.isUpdatingOldUser = false,
  });

  final AppUser appUser;
  final bool? isUpdatingOldUser;
}

class ErrorUpdatingProfile extends SetupProfileState {
  ErrorUpdatingProfile({
    required this.message,
  });

  final String message;
}

class CompanyCreated extends SetupProfileState {
  final bool? isUpdatingOldCompany;
  CompanyCreated({
    this.isUpdatingOldCompany = false,
  });
}

class UserProfileMissing extends SetupProfileState {}

class CompanyProfileMissing extends SetupProfileState {}

class AllProfilesUpdated extends SetupProfileState {}
