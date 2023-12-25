// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:menumaster_manager/domain/auth/i_auth_repository.dart';

@LazySingleton(as: IAuthRepository)
class FirebaseAuthRepository implements IAuthRepository {
  FirebaseAuthRepository(
    this._firebaseAuth,
  );

  final firebase_auth.FirebaseAuth _firebaseAuth;

  @override
  Future<User?> getSignedInUser() async => _firebaseAuth.currentUser;

  @override
  Future<void> signOut() => Future.wait([
        _firebaseAuth.signOut(),
      ]);

  @override
  Future<Either<FirebaseAuthException, Unit>> registerWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return right(unit);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseAuthException, User>> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return right(response.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseAuthException, Unit>> resetPassword(
      {required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return right(unit);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return left(e);
    }
  }

  @override
  String? get userId => _firebaseAuth.currentUser?.uid;

  @override
  Future<Either<firebase_auth.FirebaseAuthException, Unit>>
      sendEmailVerificationLink() async {
    try {
      final user = _firebaseAuth.currentUser;
      await user?.sendEmailVerification();
      return right(unit);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return left(e);
    }
  }

  @override
  bool? get isEmailVerified => _firebaseAuth.currentUser?.emailVerified;

  @override
  Future<Either<firebase_auth.FirebaseAuthException, Unit>>
      sendSignInWithEmailLink(
          {required String email,
          required firebase_auth.ActionCodeSettings actionCodeSettings}) async {
    try {
      await _firebaseAuth.sendSignInLinkToEmail(
          email: email, actionCodeSettings: actionCodeSettings);
      return right(unit);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return left(e);
    }
  }
}
