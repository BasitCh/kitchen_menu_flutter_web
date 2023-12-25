// ignore_for_file: depend_on_referenced_packages, implementation_imports
import 'package:flutter/services.dart';
import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/unit.dart';
import 'package:menumaster_manager/domain/auth/i_auth_repository.dart';
import 'package:menumaster_manager/domain/profile/company.dart';
import 'package:menumaster_manager/domain/profile/i_profile_repository.dart';
import 'package:menumaster_manager/domain/services/cloud_firestore/i_cloud_firestore_repository.dart';
import 'package:menumaster_manager/domain/services/storage/i_storage_repository.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:widgets_book/widgets_book.dart';

class ProfileRepository extends IProfileRepository {
  ProfileRepository({
    required this.firestoreRepository,
    required this.storageRepository,
    required this.authRepository,
  });

  final ICloudFirestoreRepository firestoreRepository;
  final IStorageRepository storageRepository;
  final IAuthRepository authRepository;

  @override
  Future<Either<ApiError, AppUser>> updateUserProfile(
      {required AppUser appUser}) async {
    String? userId = firebaseAuth.currentUser?.uid;

    if (userId != null) {
      final response = await firestoreRepository.updateDocument(
        collectionName: FirestoreCollection.users,
        docId: userId,
        object: appUser.toJson(),
      );
      return response.fold((l) => left(l.toApiError()), (docSnapshot) {
        AppUser updatedUser = AppUser.fromJson(docSnapshot.data() ?? {});
        return right(updatedUser);
      });
    } else {
      return left(
        ApiError(
          message: 'Invalid user credentials',
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, String>> uploadProfilePic(
      {required Uint8List file}) async {
    String? userId = firebaseAuth.currentUser?.uid;
    if (userId != null) {
      final response = await storageRepository.uploadImage(
        path: 'manager/profile_pic/$userId',
        file: file,
      );
      return response.fold(
        (l) => left(l.toApiError()),
        (r) => right(r),
      );
    } else {
      return left(
        ApiError(
          message: 'Invalid user credentials',
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, Unit>> createCompanyProfile(
      {required Company company}) async {
    String? userId = firebaseAuth.currentUser?.uid;

    if (userId != null) {
      final response = await firestoreRepository.uploadDocument(
        collectionName: FirestoreCollection.companies,
        object: company.toJson(),
      );

      return response.fold((l) => left(l.toApiError()), (docSnapshot) async {
        company.id = docSnapshot.id;
        company.userId = userId;
        company.createdAt = DateTime.now();
        await docSnapshot.update(company.toJson());
        // update the user collection with company id and name
        final AppUser user = AppUser(
          companyId: company.id,
          companyName: company.companyName,
        );

        await firestoreRepository.updateDocument(
            collectionName: FirestoreCollection.users,
            docId: userId,
            object: user.toJson());

        return right(unit);
      });
    } else {
      return left(
        ApiError(
          message: 'Invalid user credentials',
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, String>> uploadComapnyLogo(
      {required Uint8List file}) async {
    String? userId = firebaseAuth.currentUser?.uid;
    if (userId != null) {
      final response = await storageRepository.uploadImage(
        path: 'manager/company_logo/$userId',
        file: file,
      );
      return response.fold(
        (l) => left(l.toApiError()),
        (r) => right(r),
      );
    } else {
      return left(
        ApiError(
          message: 'Invalid user credentials',
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, AppUser>> getUser() async {
    String? userId = firebaseAuth.currentUser?.uid;
    if (userId != null) {
      final response = await firestoreRepository.getDocument(
          collectionName: FirestoreCollection.users, docId: userId);
      return response.fold(
        (l) => left(l.toApiError()),
        (DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
          AppUser user = AppUser.fromJson(documentSnapshot.data() ?? {});
          return right(user);
        },
      );
    } else {
      return left(
        ApiError(
          message: 'Invalid user credentials',
        ),
      );
    }
  }

  @override
  Future<Either<ApiError, AppUser>> getUserById(
      {required String userId}) async {
    final response = await firestoreRepository.getDocument(
        collectionName: FirestoreCollection.users, docId: userId);
    return response.fold(
      (l) => left(l.toApiError()),
      (DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        AppUser user = AppUser.fromJson(documentSnapshot.data() ?? {});
        return right(user);
      },
    );
  }

  @override
  Future<Either<ApiError, Company>> getManagerCompany(
      {required String companyId}) async {
    final res = await firestoreRepository.getDocument(
      collectionName: FirestoreCollection.companies,
      docId: companyId,
    );
    return res.fold((l) => left(l.toApiError()), (r) {
      final company = Company.fromJson(r.data()!);
      return right(company);
    });
  }

  @override
  Future<Either<ApiError, Unit>> updateCompanyProfile(
      {required Company company}) async {
        
    final res = await firestoreRepository.updateDocument(
      collectionName: FirestoreCollection.companies,
      docId: company.id ?? '',
      object: company.toJson(),
    );

    return res.fold(
      (l) => left(l.toApiError()),
      (r) => right(unit),
    );
  }
}
