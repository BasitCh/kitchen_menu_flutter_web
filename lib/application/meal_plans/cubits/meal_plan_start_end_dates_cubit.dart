import 'package:widgets_book/widgets_book.dart';

class MealPlanStartEndDatesState {
  MealPlanStartEndDatesState({
    this.startDate,
    this.endDate,
  });

  final DateTime? startDate;
  final DateTime? endDate;
}

class MealPlanStartEndDatesCubit extends Cubit<MealPlanStartEndDatesState> {
  MealPlanStartEndDatesCubit() : super(MealPlanStartEndDatesState());

  void initialize() {
    (DateTime, DateTime) dates = calculateMenuDateRange();
    emit(MealPlanStartEndDatesState(
      startDate: dates.$1,
      endDate: dates.$2,
    ));
  }

  void nextWeek() {
    if (state.startDate != null) {
      (DateTime, DateTime) dates = calculateMenuDateRange(
        dateTime: DateTime(
          state.startDate!.year,
          state.startDate!.month,
          state.startDate!.day + 7,
        ),
      );
      emit(MealPlanStartEndDatesState(
        startDate: dates.$1,
        endDate: dates.$2,
      ));
    }
  }

  void previousWeek(){
    if (state.startDate != null) {
      (DateTime, DateTime) dates = calculateMenuDateRange(
        dateTime: DateTime(
          state.startDate!.year,
          state.startDate!.month,
          state.startDate!.day - 7,
        ),
      );
      emit(MealPlanStartEndDatesState(
        startDate: dates.$1,
        endDate: dates.$2,
      ));
    }
  }

  update({
    required DateTime dateTime,
  }) {
    (DateTime, DateTime) dates = calculateMenuDateRange(dateTime: dateTime);
    emit(MealPlanStartEndDatesState(
      startDate: dates.$1,
      endDate: dates.$2,
    ));
  }
}
