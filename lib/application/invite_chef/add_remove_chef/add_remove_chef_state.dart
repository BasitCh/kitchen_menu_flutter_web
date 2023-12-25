part of 'add_remove_chef_bloc.dart';

@immutable
abstract class AddRemoveChefState {}

class AddRemoveChefInitial extends AddRemoveChefState {}

class AddingChef extends AddRemoveChefState {}

class ChefUpdated extends AddRemoveChefState {
  final List<ItemInvite> chefs;

  ChefUpdated({required this.chefs});
}
