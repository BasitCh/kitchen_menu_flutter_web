// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

abstract class ICloudFirestoreRepository {
  Future<Either<FirebaseException, Unit>> uploadData({
    required String collectionName,
    required String docId,
    required dynamic object,
  });

  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>>
      updateDocument({
    required String collectionName,
    required String docId,
    required dynamic object,
  });

  Future<Either<FirebaseException, DocumentReference>> uploadDocument({
    required String collectionName,
    required dynamic object,
  });

  Future<Either<FirebaseException, QuerySnapshot<Map<String, dynamic>>>>
      getCollection({
    required String collectionName,
    Object? whereKey,
    Object? whereValue,
  });

  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>>
      getDocument({
    required String collectionName,
    required String docId,
  });

  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>>
      getCompanyAllergies({
    required String collectionName,
    required String docId,
    required String innerCollectionName,
    required String innerDocId,
  });

  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>>
      getWeekDays({
    required String collectionName,
    required String docId,
    required String innerCollectionName,
    required String innerDocId,
  });

  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>>
      getNestedDocument({
    required String firstCollectionName,
    required String firstDocId,
    required String secondCollectionName,
    required String secondDocId,
  });

  Future<DocumentSnapshot<Map<String, dynamic>>> uploadCompanyAllergies(
      {required String collectionName,
      required String docId,
      required String innerCollectionName,
      required String innerDocId,
      required dynamic object});

  Future<void> updateCompanyAllergies(
      {required String collectionName,
      required String docId,
      required String innerCollectionName,
      required String innerDocId,
      required dynamic object});

  Future<void> uploadWeeklyAttendance(
      {required String collectionName,
      required String docId,
      required String innerCollectionName,
      required String innerDocId,
      required dynamic object});

  Future<Either<FirebaseException, Unit>> deleteDocument({
    required String collectionName,
    required String docId,
  });

  Future<Either<FirebaseException, QuerySnapshot<Map<String, dynamic>>>>
      getNestedMealPlanCollection({
    required String firstCollectionName,
    required String firstDocId,
    required String secondCollectionName,
    required String firstWhereKey,
    required dynamic firstWhereValue,
    required String secondWhereKey,
    required dynamic secondWhereValue,
    required String orderBy,
  });

  Future<Either<FirebaseException, QuerySnapshot<Map<String, dynamic>>>>
      getCompanyInvitations({
    required String firstCollectionName,
    required String firstDocId,
    required String secondCollectionName,
  });
}
