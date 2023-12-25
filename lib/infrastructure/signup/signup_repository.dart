// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/unit.dart';
import 'package:menumaster_manager/domain/auth/i_auth_repository.dart';
import 'package:menumaster_manager/domain/services/cloud_firestore/i_cloud_firestore_repository.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/domain/sign_up/i_signup_repository.dart';
import 'package:widgets_book/widgets_book.dart';

class SignupRepository implements ISignupRepository {
  SignupRepository({
    required this.authRepository,
    required this.firestoreRepository,
  });

  final IAuthRepository authRepository;
  final ICloudFirestoreRepository firestoreRepository;

  @override
  Future<Either<ApiError, Unit>> createNewUser(
      {required String email, required String password}) async {
    final response = await authRepository.registerWithEmailAndPassword(
      emailAddress: email,
      password: password,
    );
    return response.fold(
      (l) => left(l.toApiError()),
      (r) => right(unit),
    );
  }

  @override
  Future<Either<ApiError, AppUser>> saveUser({required AppUser appUser}) async {
    final response = await firestoreRepository.uploadData(
      collectionName: FirestoreCollection.users,
      docId: appUser.id ?? '',
      object: appUser.toJson(),
    );
    return response.fold((l) => left(l.toApiError()), (r) {
      // print('Document reference id is: ${r.id}');
      return right(
        appUser,
      );
    });
  }

  @override
  Future<Either<ApiError, Unit>> sendEmailVerificationLink() async {
    final response = await authRepository.sendEmailVerificationLink();
    return response.fold(
      (l) => left(l.toApiError()),
      (r) => right(unit),
    );
  }

  @override
  bool? get isEmailVerified => authRepository.isEmailVerified;

  @override
  Future<Either<ApiError, Unit>> sendSignInLinkToEmail(
      {required String email,
      required ActionCodeSettings actionCodeSettings}) async {
    final response = await authRepository.sendSignInWithEmailLink(
        email: email, actionCodeSettings: actionCodeSettings);
    return response.fold(
      (l) => left(l.toApiError()),
      (r) => right(unit),
    );
  }
}
