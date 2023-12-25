// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

abstract class IAuthRepository {
  Future<User?> getSignedInUser();

  Future<void> signOut();

  Future<Either<FirebaseAuthException, Unit>> registerWithEmailAndPassword({
    required String emailAddress,
    required String password,
  });

  Future<Either<FirebaseAuthException, User>> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  });

  Future<Either<FirebaseAuthException, Unit>> sendEmailVerificationLink();

  String? get userId;

  bool? get isEmailVerified;

  Future<Either<FirebaseAuthException, Unit>> resetPassword({
    required String email,
  });

  Future<Either<FirebaseAuthException, Unit>> sendSignInWithEmailLink(
      {required String email, required ActionCodeSettings actionCodeSettings});
}
