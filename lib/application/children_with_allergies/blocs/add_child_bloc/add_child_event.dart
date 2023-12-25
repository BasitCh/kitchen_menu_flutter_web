part of 'add_child_bloc.dart';

@immutable
sealed class AddChildEvent {}

class AddChild extends AddChildEvent {
  final Child child;

  AddChild({required this.child});
}

class UpdateChild extends AddChildEvent {
  final Child child;

  UpdateChild({required this.child});
}

class RemoveChild extends AddChildEvent {
  final Child child;
  RemoveChild({required this.child});
}
