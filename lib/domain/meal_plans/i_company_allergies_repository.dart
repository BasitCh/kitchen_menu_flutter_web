// ignore_for_file: depend_on_referenced_packages

import 'package:fpdart/fpdart.dart';
import 'package:menumaster_manager/domain/meal_plans/company_allergies.dart';
import 'package:widgets_book/widgets_book.dart';

abstract class ICompanyAllergiesRepository {
  Future<Either<ApiError, CompanyAllergies>> getCompanyAllergies({
    required String companyId,
  });
}
