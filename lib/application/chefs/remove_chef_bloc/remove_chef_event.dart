part of 'remove_chef_bloc.dart';

@immutable
sealed class RemoveChefEvent {}

class RemoveChef extends RemoveChefEvent {
  final AppUser user;
  RemoveChef({required this.user});
}
