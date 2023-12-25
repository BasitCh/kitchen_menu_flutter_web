// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:menumaster_manager/domain/profile/company.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/infrastructure/profile/profile_repository.dart';
import 'package:meta/meta.dart';

part 'manager_profile_event.dart';
part 'manager_profile_state.dart';

class ManagerProfileBloc
    extends Bloc<ManagerProfileEvent, ManagerProfileState> {
  final ProfileRepository profileRepository;

  ManagerProfileBloc({required this.profileRepository})
      : super(ManagerProfileInitial()) {
    on<GetUser>(_onGetUser);
    on<GetCompany>(_onGetCompany);
  }

  Future<void> _onGetUser(
      GetUser event, Emitter<ManagerProfileState> emit) async {
    emit(LoadingUser());
    final response = await profileRepository.getUser();
    response.fold(
      (l) => emit(
        ErrorLoadingUser(error: 'Unable to fetch user'),
      ),
      (r) => add(
        GetCompany(appUser: r),
      ),
    );
  }

  Future<void> _onGetCompany(
      GetCompany event, Emitter<ManagerProfileState> emit) async {
    emit(LoadingCompany());
    final response = await profileRepository.getManagerCompany(
        companyId: event.appUser.companyId ?? '');
    response.fold(
      (l) => emit(
        ErrorLoadingCompany(error: 'Unable to fetch company'),
      ),
      (r) => emit(
        CompanyLoaded(appUser: event.appUser, company: r),
      ),
    );
  }
}
