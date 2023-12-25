part of 'attendance_bloc.dart';

@immutable
sealed class AttendanceEvent {}

class GetWeekDays extends AttendanceEvent {
  final Child? child;

  GetWeekDays({
   this.child,
  });
}

class ToggleDay extends AttendanceEvent {
  final Day day;

  ToggleDay({
    required this.day,
  });
}

class ClearSelectedDays extends AttendanceEvent {}
