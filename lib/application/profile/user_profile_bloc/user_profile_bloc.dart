// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/infrastructure/profile/profile_repository.dart';
import 'package:meta/meta.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final ProfileRepository profileRepository;

  UserProfileBloc({required this.profileRepository}) : super(UserProfileInitial()) {
    on<FetchUserById>(_onGetUserById);
  }

  Future<void> _onGetUserById(
      FetchUserById event, Emitter<UserProfileState> emit) async {
    emit(LoadingUser());
    final response = await profileRepository.getUserById(userId: event.userId);
    response.fold(
      (l) => emit(
        ErrorLoadingUser(error: 'Unable to fetch user'),
      ),
      (r) => emit(
        UserLoaded(user: r),
      ),
    );
  }
}
