// ignore_for_file: depend_on_referenced_packages
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:menumaster_manager/domain/profile/company.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:widgets_book/widgets_book.dart';

abstract class IProfileRepository {
  Future<Either<ApiError, AppUser>> updateUserProfile({
    required AppUser appUser,
  });

  Future<Either<ApiError, String>> uploadProfilePic({
    required Uint8List file,
  });

  Future<Either<ApiError, Unit>> createCompanyProfile({
    required Company company,
  });

  Future<Either<ApiError, String>> uploadComapnyLogo({
    required Uint8List file,
  });

  Future<Either<ApiError, AppUser>> getUser();

  Future<Either<ApiError, AppUser>> getUserById({required String userId});

  Future<Either<ApiError, Company>> getManagerCompany({
    required String companyId,
  });

  Future<Either<ApiError, Unit>> updateCompanyProfile(
      {required Company company});
}
