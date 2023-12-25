part of 'add_remove_chef_bloc.dart';

@immutable
abstract class AddRemoveChefEvent {}

class AddChef extends AddRemoveChefEvent {
  final ItemInvite chef;

  AddChef({required this.chef});
}

class RemoveChef extends AddRemoveChefEvent {
  final int index;
  RemoveChef({required this.index});
}
