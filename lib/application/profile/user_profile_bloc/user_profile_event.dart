part of 'user_profile_bloc.dart';

@immutable
sealed class UserProfileEvent {}

class FetchUserById extends UserProfileEvent {
  final String userId;

  FetchUserById({required this.userId});
}
