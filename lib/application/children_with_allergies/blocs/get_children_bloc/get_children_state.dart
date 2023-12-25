part of 'get_children_bloc.dart';

@immutable
sealed class GetChildrenState {}

final class GetChildrenInitial extends GetChildrenState {}

class GettingChildren extends GetChildrenState {}

class ErrorGettingChildren extends GetChildrenState {
  final String error;

  ErrorGettingChildren({required this.error});
}

class ChildrenFetched extends GetChildrenState {
  final List<Child> children;

  ChildrenFetched({required this.children});
}

class NoChildrenFound extends GetChildrenState {}