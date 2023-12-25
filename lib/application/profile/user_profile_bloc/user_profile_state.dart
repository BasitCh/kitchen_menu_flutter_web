part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileState {}

final class UserProfileInitial extends UserProfileState {}

class LoadingUser extends UserProfileState {}


class UserLoaded extends UserProfileState {
  final AppUser? user;

  UserLoaded({required this.user});
}

class ErrorLoadingUser extends UserProfileState {
  final String error;

  ErrorLoadingUser({
    required this.error,
  });
}