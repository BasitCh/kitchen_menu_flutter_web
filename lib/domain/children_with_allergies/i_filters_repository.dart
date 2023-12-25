// ignore_for_file: depend_on_referenced_packages

import 'package:fpdart/fpdart.dart';
import 'package:menumaster_manager/domain/children_with_allergies/filters.dart';
import 'package:widgets_book/widgets_book.dart';

abstract class IFiltersRepository {
  Future<Either<ApiError, Filters>> getAllergies();
  Future<void> addAllergy({required List<String> allergies});
  Future<void> createWeeklyAttendance({required List<String> days});
  Future<Either<ApiError, List<String>>> getWeeklyAttendance();
}
