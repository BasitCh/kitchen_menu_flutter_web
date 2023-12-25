// ignore_for_file: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:menumaster_manager/domain/profile/company.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/infrastructure/profile/profile_repository.dart';
import 'package:meta/meta.dart';

part 'setup_profile_event.dart';
part 'setup_profile_state.dart';

class SetupProfileBloc extends Bloc<SetupProfileEvent, SetupProfileState> {
  final ProfileRepository profileRepository;

  SetupProfileBloc({required this.profileRepository})
      : super(SetupProfileInitial()) {
    on<UpdateUserProfile>(_onUpdateUserProfile);
    on<UploadUserProfilePic>(_onUploadUserProfilePic);
    on<CreateCompany>(_onCreatingCompanyProfile);
    on<UpdateCompanyLogo>(_onUploadingCompanyLogo);
    on<CheckManagerProfiles>(_onCheckProfileUpdated);
  }

  Future<void> _onUpdateUserProfile(
      UpdateUserProfile event, Emitter<SetupProfileState> emit) async {
    emit(UpdatingProfile());
    if (event.file != null) {
      add(UploadUserProfilePic(appUser: event.appUser, file: event.file!));
    } else {
      final response =
          await profileRepository.updateUserProfile(appUser: event.appUser);
      response.fold(
        (apiError) => emit(ErrorUpdatingProfile(
          message: apiError.message ?? 'Failed to connect',
        )),
        (appUser) => emit(ProfileUpdated(
          appUser: appUser,
          isUpdatingOldUser: event.isUpdatingOldUser,
        )),
      );
    }
  }

  Future<void> _onUploadUserProfilePic(
      UploadUserProfilePic event, Emitter<SetupProfileState> emit) async {
    final response = await profileRepository.uploadProfilePic(
      file: event.file,
    );
    response.fold(
      (apiError) => emit(ErrorUpdatingProfile(
        message: apiError.message ?? 'Failed to connect',
      )),
      (imageUrl) => add(
        UpdateUserProfile(
          appUser: event.appUser.copyWith(imageUrl: imageUrl),
        ),
      ),
    );
  }

  Future<void> _onCreatingCompanyProfile(
      CreateCompany event, Emitter<SetupProfileState> emit) async {
    emit(UpdatingProfile());
    if (event.companyLogo != null) {
      add(UpdateCompanyLogo(
          company: event.company, companyLogo: event.companyLogo!));
    } else {
      final response = event.isUpdatingOldCompany!
          ? await profileRepository.updateCompanyProfile(company: event.company)
          : await profileRepository.createCompanyProfile(
              company: event.company);
      response.fold(
          (apiError) => emit(ErrorUpdatingProfile(
                message: apiError.message ?? 'Failed to connect',
              )),
          (_) => emit(CompanyCreated(
              isUpdatingOldCompany: event.isUpdatingOldCompany)));
    }
  }

  Future<void> _onUploadingCompanyLogo(
      UpdateCompanyLogo event, Emitter<SetupProfileState> emit) async {
    final response =
        await profileRepository.uploadComapnyLogo(file: event.companyLogo);
    response.fold(
      (apiError) => emit(ErrorUpdatingProfile(
        message: apiError.message ?? 'Failed to connect',
      )),
      (imageUrl) => add(
        CreateCompany(
          company: event.company.copyWith(companyLogo: imageUrl),
        ),
      ),
    );
  }

  Future<void> _onCheckProfileUpdated(
      CheckManagerProfiles event, Emitter<SetupProfileState> emit) async {
    emit(UpdatingProfile());
    final response = await profileRepository.getUser();

    response.fold(
        (error) => emit(
              ErrorUpdatingProfile(
                message: error.message ?? 'Error getting user profile',
              ),
            ), (user) {
      if (user.companyId == null || user.companyId == '') {
        emit(CompanyProfileMissing());
      } else if ((user.firstName == null || user.lastName == null)) {
        emit(UserProfileMissing());
      } else {
        emit(AllProfilesUpdated());
      }
    });
  }
}
