// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/unit.dart';
import 'package:menumaster_manager/domain/children_with_allergies/child.dart';
import 'package:menumaster_manager/domain/children_with_allergies/i_children_repository.dart';
import 'package:menumaster_manager/domain/services/cloud_firestore/i_cloud_firestore_repository.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:menumaster_manager/infrastructure/services/shared_preferences_helper.dart';
import 'package:widgets_book/widgets_book.dart';

class ChildrenRepository extends IChildrenRepository {
  final ICloudFirestoreRepository cloudFirestoreRepository;

  ChildrenRepository({required this.cloudFirestoreRepository});

  @override
  Future<Either<ApiError, Unit>> addChild({required Child child}) async {
    try {
      final response = await firestore
          .collection(FirestoreCollection.companies)
          .doc(child.companyId)
          .collection(FirestoreCollection.children)
          .add(child.toJson());

      child.childId = response.id;
      await firestore
          .collection(FirestoreCollection.companies)
          .doc(child.companyId)
          .collection(FirestoreCollection.children)
          .doc(child.childId)
          .update(child.toJson());

      return right(unit);
    } on FirebaseException catch (e) {
      return left(ApiError(code: e.code, message: e.message));
    }
  }

  @override
  Future<Either<ApiError, List<Child>>> getChildren() async {
    final appUser = await SharedPreferenceService.getUser();
    try {
      final res = await firestore
          .collection(FirestoreCollection.companies)
          .doc(appUser?.companyId)
          .collection(FirestoreCollection.children)
          .get();
      List<Child> children = [];
      for (var doc in res.docs) {
        Child child = Child.fromJson(doc.data());
        children.add(child);
      }
      return right(children);
    } on FirebaseException catch (e) {
      return left(ApiError(code: e.code, message: e.message));
    }
  }

  @override
  Future<Either<ApiError, Unit>> updateChild({required Child child}) async {
    try {
      await firestore
          .collection(FirestoreCollection.companies)
          .doc(child.companyId)
          .collection(FirestoreCollection.children)
          .doc(child.childId)
          .update(child.toJson());

      return right(unit);
    } on FirebaseException catch (e) {
      return left(ApiError(code: e.code, message: e.message));
    }
  }

  @override
  Future<Either<ApiError, Unit>> deleteChild({required Child child}) async {
    try {
      await firestore
          .collection(FirestoreCollection.companies)
          .doc(child.companyId)
          .collection(FirestoreCollection.children)
          .doc(child.childId)
          .delete();

      return right(unit);
    } on FirebaseException catch (e) {
      return left(ApiError(code: e.code, message: e.message));
    }
  }
}
