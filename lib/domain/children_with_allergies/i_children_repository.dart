// ignore_for_file: depend_on_referenced_packages

import 'package:fpdart/fpdart.dart';
import 'package:menumaster_manager/domain/children_with_allergies/child.dart';
import 'package:widgets_book/widgets_book.dart';

abstract class IChildrenRepository {
  Future<Either<ApiError, Unit>> addChild({required Child child});

  Future<Either<ApiError, Unit>> updateChild({required Child child});

    Future<Either<ApiError, Unit>> deleteChild({required Child child});

  Future<Either<ApiError, List<Child>>> getChildren();
}
