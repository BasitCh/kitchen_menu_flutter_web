// ignore_for_file: depend_on_referenced_packages

import 'package:menumaster_manager/domain/children_with_allergies/child.dart';
import 'package:menumaster_manager/infrastructure/children_with_allergies/filters_repository.dart';
import 'package:meta/meta.dart';
import 'package:widgets_book/widgets_book.dart';

part 'attendance_event.dart';
part 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final FiltersRepository filtersRepository;
  final List<Day> localDays = [];

  AttendanceBloc({
    required this.filtersRepository,
  }) : super(AttendanceInitial()) {
    on<GetWeekDays>(_onGetWeekDays);
    on<ToggleDay>(_onToggleDay);
    on<ClearSelectedDays>(_onClearAppliedDays);
  }

  Future<void> _onGetWeekDays(
    GetWeekDays event,
    Emitter<AttendanceState> emit,
  ) async {
    final response = await filtersRepository.getWeeklyAttendance();

    response.fold(
        (ApiError apiError) => emit(
              ErrorFetchingWeekDays(
                error: apiError.message ?? 'Error getting week days',
              ),
            ), (days) {
      localDays.clear();
      for (var day in days) {
        {
          if (event.child != null &&
              event.child?.weeklyAttendance != null &&
              event.child!.weeklyAttendance!.isNotEmpty &&
              event.child!.weeklyAttendance!.contains(day)) {
            final selectedDay = Day(name: day, isSelected: true);
            localDays.add(selectedDay);
          } else {
            localDays.add(Day(name: day, isSelected: false));
          }
        }
      }
      emit(
        WeekDaysFetched(
          days: localDays,
        ),
      );
    });
  }

  Future<void> _onToggleDay(
    ToggleDay event,
    Emitter<AttendanceState> emit,
  ) async {
    final index = localDays.indexOf(event.day);

    localDays[index] = Day(
        name: localDays[index].name, isSelected: !localDays[index].isSelected!);
    emit(
      WeekDaysFetched(days: localDays),
    );
  }

  Future<void> _onClearAppliedDays(
    ClearSelectedDays event,
    Emitter<AttendanceState> emit,
  ) async {
    for (Day day in localDays) {
      day.isSelected = false;
    }
    emit(
      WeekDaysFetched(days: localDays),
    );
  }
}

class Day {
  String name;
  bool? isSelected;
  Day({
    required this.name,
    this.isSelected = false,
  });
}
