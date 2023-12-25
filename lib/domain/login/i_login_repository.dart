// ignore_for_file: depend_on_referenced_packages

import 'package:fpdart/fpdart.dart';
import 'package:widgets_book/widgets_book.dart';

abstract class ILoginRepository {
  Future<Either<FirebaseAuthException, User>> login({
    required String email,
    required String password,
  });

  Future<Either<FirebaseAuthException, Unit>> resetPasswordEmail(
      {required String email});
}
