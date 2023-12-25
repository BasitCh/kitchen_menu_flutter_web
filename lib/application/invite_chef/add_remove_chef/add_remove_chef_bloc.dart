// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:menumaster_manager/presentation/invite_chefs/widgets/item_invite.dart';

part 'add_remove_chef_event.dart';
part 'add_remove_chef_state.dart';

class AddRemoveChefBloc extends Bloc<AddRemoveChefEvent, AddRemoveChefState> {
  List<ItemInvite> chefs = [];

  AddRemoveChefBloc() : super(AddRemoveChefInitial()) {
    on<AddChef>(onAddChef);
    on<RemoveChef>(onRemoveChef);
  }

  Future<void> onAddChef(
    AddChef event,
    Emitter<AddRemoveChefState> emit,
  ) async {
    emit(AddingChef());
    chefs.add(event.chef);
    emit(ChefUpdated(chefs: chefs));
  }

  Future<void> onRemoveChef(
    RemoveChef event,
    Emitter<AddRemoveChefState> emit,
  ) async {
    emit(AddingChef());
    chefs.removeAt(event.index);
    emit(ChefUpdated(chefs: chefs));
  }
}
