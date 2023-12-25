part of 'setup_profile_bloc.dart';

@immutable
sealed class SetupProfileEvent {}

class UpdateUserProfile extends SetupProfileEvent {
  UpdateUserProfile({
    required this.appUser,
    this.file,
    this.isUpdatingOldUser = false,
  });

  final AppUser appUser;
  final Uint8List? file;
  final bool? isUpdatingOldUser;
}

class UploadUserProfilePic extends SetupProfileEvent {
  UploadUserProfilePic({
    required this.appUser,
    required this.file,
  });
  final AppUser appUser;
  final Uint8List file;
}

class CreateCompany extends SetupProfileEvent {
  final Company company;
  final Uint8List? companyLogo;
  final bool? isUpdatingOldCompany;

  CreateCompany({required this.company, this.companyLogo, this.isUpdatingOldCompany = false});
}

class UpdateCompanyLogo extends SetupProfileEvent {
  final Company company;
  final Uint8List companyLogo;

  UpdateCompanyLogo({required this.company, required this.companyLogo});
}

class CheckManagerProfiles extends SetupProfileEvent {
  CheckManagerProfiles();
}
