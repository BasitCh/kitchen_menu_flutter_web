// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/unit.dart';
import 'package:injectable/injectable.dart';

import '../../domain/services/cloud_firestore/i_cloud_firestore_repository.dart';

@LazySingleton(as: ICloudFirestoreRepository)
class FirestoreService implements ICloudFirestoreRepository {
  FirestoreService(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<Either<FirebaseException, Unit>> uploadData({
    required String collectionName,
    required String docId,
    required dynamic object,
  }) async {
    try {
      await _firestore.collection(collectionName).doc(docId).set(object);
      return right(unit);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, DocumentReference>> uploadDocument({
    required String collectionName,
    required dynamic object,
  }) async {
    try {
      DocumentReference docRef =
          await _firestore.collection(collectionName).add(object);
      return right(docRef);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, QuerySnapshot<Map<String, dynamic>>>>
      getCollection({
    required String collectionName,
    Object? whereKey,
    Object? whereValue,
  }) async {
    try {
      late QuerySnapshot<Map<String, dynamic>> documentSnapshot;
      if (whereKey != null) {
        await _firestore
            .collection(collectionName)
            .where(whereKey, isEqualTo: whereValue)
            .get()
            .then(
              (QuerySnapshot<Map<String, dynamic>> value) =>
                  documentSnapshot = value,
            );
      } else {
        await _firestore.collection(collectionName).get().then(
              (QuerySnapshot<Map<String, dynamic>> value) =>
                  documentSnapshot = value,
            );
      }
      return right(documentSnapshot);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>>
      getDocument(
          {required String collectionName, required String docId}) async {
    try {
      late DocumentSnapshot<Map<String, dynamic>> documentSnapshot;
      await _firestore.collection(collectionName).doc(docId).get().then(
            (DocumentSnapshot<Map<String, dynamic>> value) =>
                documentSnapshot = value,
          );
      return right(documentSnapshot);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>>
      updateDocument(
          {required String collectionName,
          required String docId,
          required object}) async {
    try {
      await _firestore.collection(collectionName).doc(docId).set(
            object,
            SetOptions(merge: true),
          );
      final response =
          await _firestore.collection(collectionName).doc(docId).get();
      return right(response);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, Unit>> deleteDocument(
      {required String collectionName, required String docId}) async {
    try {
      await _firestore.collection(collectionName).doc(docId).delete();
      return right(unit);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
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
  }) async {
    try {
      QuerySnapshot<Map<String, dynamic>> documentSnapshot = await _firestore
          .collection(firstCollectionName)
          .doc(firstDocId)
          .collection(secondCollectionName)
          // .orderBy(orderBy)
          .where(firstWhereKey, isEqualTo: firstWhereValue)
          .where(secondWhereKey, isEqualTo: secondWhereValue)
          .get();
      return right(documentSnapshot);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>>
      getCompanyAllergies({
    required String collectionName,
    required String docId,
    required String innerCollectionName,
    required String innerDocId,
  }) async {
    try {
      late DocumentSnapshot<Map<String, dynamic>> documentSnapshot;
      await _firestore
          .collection(collectionName)
          .doc(docId)
          .collection(innerCollectionName)
          .doc(innerDocId)
          .get()
          .then(
            (DocumentSnapshot<Map<String, dynamic>> value) =>
                documentSnapshot = value,
          );
      return right(documentSnapshot);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> uploadCompanyAllergies(
      {required String collectionName,
      required String docId,
      required String innerCollectionName,
      required String innerDocId,
      required object}) async {
    try {
      await _firestore
          .collection(collectionName)
          .doc(docId)
          .collection(innerCollectionName)
          .doc(innerDocId)
          .set(
            object,
            SetOptions(merge: true),
          );

      final response = await _firestore
          .collection(collectionName)
          .doc(docId)
          .collection(innerCollectionName)
          .doc(innerDocId)
          .get();
      return response;
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> updateCompanyAllergies(
      {required String collectionName,
      required String docId,
      required String innerCollectionName,
      required String innerDocId,
      required object}) async {
    try {
      await _firestore
          .collection(collectionName)
          .doc(docId)
          .collection(innerCollectionName)
          .doc(innerDocId)
          .update(
            object,
          );
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<Either<FirebaseException, QuerySnapshot<Map<String, dynamic>>>>
      getCompanyInvitations(
          {required String firstCollectionName,
          required String firstDocId,
          required String secondCollectionName}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> documentSnapshot = await _firestore
          .collection(firstCollectionName)
          .doc(firstDocId)
          .collection(secondCollectionName)
          .get();
      return right(documentSnapshot);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>>
      getNestedDocument(
          {required String firstCollectionName,
          required String firstDocId,
          required String secondCollectionName,
          required String secondDocId}) async {
    try {
      late DocumentSnapshot<Map<String, dynamic>> documentSnapshot;
      await _firestore
          .collection(firstCollectionName)
          .doc(firstDocId)
          .collection(secondCollectionName)
          .doc(secondDocId)
          .get()
          .then(
            (DocumentSnapshot<Map<String, dynamic>> value) =>
                documentSnapshot = value,
          );
      return right(documentSnapshot);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }

  @override
  Future<void> uploadWeeklyAttendance(
      {required String collectionName,
      required String docId,
      required String innerCollectionName,
      required String innerDocId,
      required object}) async {
    try {
      await _firestore
          .collection(collectionName)
          .doc(docId)
          .collection(innerCollectionName)
          .doc(innerDocId)
          .set(
            object,
          );
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<Either<FirebaseException, DocumentSnapshot<Map<String, dynamic>>>>
      getWeekDays(
          {required String collectionName,
          required String docId,
          required String innerCollectionName,
          required String innerDocId}) async {
    try {
      late DocumentSnapshot<Map<String, dynamic>> documentSnapshot;
      await _firestore
          .collection(collectionName)
          .doc(docId)
          .collection(innerCollectionName)
          .doc(innerDocId)
          .get()
          .then(
            (DocumentSnapshot<Map<String, dynamic>> value) =>
                documentSnapshot = value,
          );
      return right(documentSnapshot);
    } on FirebaseException catch (e) {
      return left(e);
    }
  }
}
