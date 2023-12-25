// ignore_for_file: depend_on_referenced_packages

import 'package:fpdart/fpdart.dart';
import 'package:menumaster_manager/domain/profile/company.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:widgets_book/widgets_book.dart';

abstract class IChefsRepository {
  Future<Either<ApiError, Company>> getCompany();

  Future<Either<ApiError, List<AppUser>>> getCompanyUsers();

}
