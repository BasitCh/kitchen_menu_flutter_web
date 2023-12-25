// ignore_for_file: depend_on_referenced_packages

import 'package:menumaster_manager/domain/children_with_allergies/child.dart';
import 'package:menumaster_manager/infrastructure/children_with_allergies/children_repository.dart';
import 'package:meta/meta.dart';
import 'package:widgets_book/widgets_book.dart';

part 'add_child_event.dart';
part 'add_child_state.dart';

class AddChildBloc extends Bloc<AddChildEvent, AddChildState> {
  final ChildrenRepository childrenRepository;

  AddChildBloc({required this.childrenRepository}) : super(AddChildInitial()) {
    on<AddChild>(_onAddChild);
    on<UpdateChild>(_onUpdateChild);
    on<RemoveChild>(_onRemoveChild);
  }

  Future<void> _onAddChild(
    AddChild event,
    Emitter<AddChildState> emit,
  ) async {
    emit(AddingChild());
    final response = await childrenRepository.addChild(child: event.child);

    response.fold(
        (ApiError apiError) => emit(
              ErrorAddingChild(
                error: apiError.message ?? 'Error adding child',
              ),
            ), (_) {
      emit(ChildAdded());
    });
  }

  Future<void> _onUpdateChild(
    UpdateChild event,
    Emitter<AddChildState> emit,
  ) async {
    emit(AddingChild());
    final response = await childrenRepository.updateChild(child: event.child);

    response.fold(
        (ApiError apiError) => emit(
              ErrorAddingChild(
                error: apiError.message ?? 'Error adding child',
              ),
            ), (_) {
      emit(ChildAdded());
    });
  }

  Future<void> _onRemoveChild(
    RemoveChild event,
    Emitter<AddChildState> emit,
  ) async {
    emit(RemovingChild());
    final response = await childrenRepository.deleteChild(child: event.child);

    response.fold(
        (ApiError apiError) => emit(
              ErrorRemovingChild(error: 'Error Removing the child'),
            ), (_) {
      emit(ChildRemoved());
    });
  }
}
