part of 'remove_chef_bloc.dart';

@immutable
sealed class RemoveChefState {}

final class RemoveChefInitial extends RemoveChefState {}

class RemovingChef extends RemoveChefState {}

class ChefRemoved extends RemoveChefState {}

class ErrorRemovingChef extends RemoveChefState {
  final String error;

  ErrorRemovingChef({required this.error});
}
