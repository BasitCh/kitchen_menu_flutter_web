// ignore_for_file: depend_on_referenced_packages

import 'package:menumaster_manager/application/children_with_allergies/blocs/attendance_bloc/attendance_bloc.dart';
import 'package:menumaster_manager/domain/children_with_allergies/allergic_filter.dart';
import 'package:menumaster_manager/domain/children_with_allergies/child.dart';
import 'package:menumaster_manager/infrastructure/children_with_allergies/children_repository.dart';
import 'package:meta/meta.dart';
import 'package:widgets_book/widgets_book.dart';

part 'get_children_event.dart';
part 'get_children_state.dart';

class GetChildrenBloc extends Bloc<GetChildrenEvent, GetChildrenState> {
  final ChildrenRepository childrenRepository;
  List<Child> childrenList = [];

  GetChildrenBloc({required this.childrenRepository})
      : super(GetChildrenInitial()) {
    on<GetChildren>(_onGetChildren);
    on<GetFilteredChildren>(_onGetFilteredChildren);
    on<RestoreLocalChildren>(_onRestoreLocalChildren);
  }

  Future<void> _onGetChildren(
    GetChildren event,
    Emitter<GetChildrenState> emit,
  ) async {
    final response = await childrenRepository.getChildren();

    response.fold(
        (ApiError apiError) => emit(
              ErrorGettingChildren(
                error: apiError.message ?? 'Error getting children',
              ),
            ), (children) {
      children.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      childrenList = children;
      if (childrenList.isEmpty) {
        emit(NoChildrenFound());
      } else {
        emit(
          ChildrenFetched(
            children: children,
          ),
        );
      }
    });
  }

  void _onGetFilteredChildren(
    GetFilteredChildren event,
    Emitter<GetChildrenState> emit,
  ) {
    final List<Child> filteredChildren = [];
    if (childrenList.isNotEmpty) {
      if (event.selectedFilters != null && event.selectedFilters!.isNotEmpty) {
        for (AllergicFilter allergicFilter in event.selectedFilters!) {
          for (Child child in childrenList) {
            if (child.allergies!.contains(allergicFilter.name)) {
              filteredChildren.add(child);
            }
          }
        }
      } 
       if (event.selectedDays != null && event.selectedDays!.isNotEmpty) {
        for (Day day in event.selectedDays!) {
          for (Child child in childrenList) {
            if (child.weeklyAttendance != null &&
                child.weeklyAttendance!.isNotEmpty &&
                child.weeklyAttendance!.contains(day.name)) {
              filteredChildren.add(child);
            }
          }
        }
      }
      if (filteredChildren.isEmpty) {
        emit(NoChildrenFound());
      } else {
        emit(ChildrenFetched(children: filteredChildren.toSet().toList()));
      }
    }
  }

  Future<void> _onRestoreLocalChildren(
    RestoreLocalChildren event,
    Emitter<GetChildrenState> emit,
  ) async {
    emit(ChildrenFetched(children: childrenList));
  }
}
