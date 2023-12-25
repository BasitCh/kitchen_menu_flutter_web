part of 'manager_profile_bloc.dart';

@immutable
sealed class ManagerProfileEvent {}

class GetUser extends ManagerProfileEvent {}

class GetCompany extends ManagerProfileEvent {
  final AppUser appUser;
  GetCompany({
    required this.appUser,
  });
}
