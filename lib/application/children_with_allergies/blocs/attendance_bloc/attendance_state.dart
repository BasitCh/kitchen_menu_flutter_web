part of 'attendance_bloc.dart';

@immutable
sealed class AttendanceState {}

final class AttendanceInitial extends AttendanceState {}

class FetchingWeekDays extends AttendanceState {}

class ErrorFetchingWeekDays extends AttendanceState {
  final String error;

  ErrorFetchingWeekDays({
    required this.error,
  });
}

class WeekDaysFetched extends AttendanceState {
  final List<Day> days;

  WeekDaysFetched({
    required this.days,
  });
}

class DaysToggledForOldChild extends AttendanceState {
  final List<Day> selectedDays;
  DaysToggledForOldChild({
    required this.selectedDays,
  });
}
