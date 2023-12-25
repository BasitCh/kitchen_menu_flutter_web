// ignore_for_file: depend_on_referenced_packages

import 'package:fpdart/fpdart.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:widgets_book/widgets_book.dart';

abstract class ISignupRepository {
  Future<Either<ApiError, Unit>> createNewUser({
    required String email,
    required String password,
  });

  Future<Either<ApiError, AppUser>> saveUser({required AppUser appUser});

  Future<Either<ApiError, Unit>> sendEmailVerificationLink();

  Future<Either<ApiError, Unit>> sendSignInLinkToEmail(
      {required String email, required ActionCodeSettings actionCodeSettings});

  bool? get isEmailVerified;
}
