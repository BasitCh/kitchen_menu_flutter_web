part of 'add_child_bloc.dart';

@immutable
sealed class AddChildState {}

final class AddChildInitial extends AddChildState {}

class AddingChild extends AddChildState {}

class ChildAdded extends AddChildState {}

class ErrorAddingChild extends AddChildState {
  final String error;

  ErrorAddingChild({required this.error});
}

class RemovingChild extends AddChildState {}

class ChildRemoved extends AddChildState {}

class ErrorRemovingChild extends AddChildState {
  final String error;
  ErrorRemovingChild({required this.error});
}
