// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'package:fpdart/src/either.dart';
import 'package:menumaster_manager/domain/invite_chefs/i_invite_repository.dart';
import 'package:menumaster_manager/domain/invite_chefs/invite.dart';
import 'package:menumaster_manager/domain/services/cloud_firestore/i_cloud_firestore_repository.dart';
import 'package:menumaster_manager/infrastructure/di/injectable.dart';
import 'package:widgets_book/widgets_book.dart';

class InviteRepository extends IInviteRepository {
  final ICloudFirestoreRepository firestoreRepository;

  InviteRepository({required this.firestoreRepository});

  @override
  Future<Either<ApiError, String>> inviteCompanyChef(
      {required String companyId, required Invite invite}) async {
    try {
      final response = await firestore
          .collection(FirestoreCollection.companies)
          .doc(companyId)
          .collection(FirestoreCollection.invitations)
          .add(invite.toJson());

      return right(response.id);
    } on FirebaseException catch (e) {
      return left(ApiError(code: e.code, message: e.message));
    }
  }
}
