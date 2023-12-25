// ignore_for_file: depend_on_referenced_packages, implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:menumaster_manager/domain/chefs/i_chefs_repository.dart';
import 'package:menumaster_manager/domain/profile/company.dart';
import 'package:menumaster_manager/domain/services/cloud_firestore/i_cloud_firestore_repository.dart';
import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:menumaster_manager/infrastructure/services/shared_preferences_helper.dart';
import 'package:widgets_book/widgets_book.dart';

class ChefsRepository extends IChefsRepository {
  final ICloudFirestoreRepository cloudFirestoreRepository;

  ChefsRepository({required this.cloudFirestoreRepository});

  @override
  Future<Either<ApiError, Company>> getCompany() async {
    final appUser = await SharedPreferenceService.getUser();
    final res = await cloudFirestoreRepository.getDocument(
        collectionName: FirestoreCollection.companies,
        docId: appUser?.companyId ?? '');
    return res.fold((l) => left(l.toApiError()), (r) {
      final company = Company.fromJson(r.data()!);
      return right(company);
    });
  }

  @override
  Future<Either<ApiError, List<AppUser>>> getCompanyUsers() async {
    final appUser = await SharedPreferenceService.getUser();
    final res = await cloudFirestoreRepository.getCollection(
        collectionName: FirestoreCollection.users,
        whereKey: 'company_id',
        whereValue: appUser?.companyId);
    return res.fold((l) => left(l.toApiError()), (r) async {
      List<AppUser> companyUsers = [];
      for (var doc in r.docs) {
        AppUser user = AppUser.fromJson(doc.data());
        companyUsers.add(user);
      }
      final allUsers = await getInvitedUsers(
          companyId: appUser?.companyId ?? '', companyUsers: companyUsers);

      return right(allUsers);
    });
  }

  Future<List<AppUser>> getInvitedUsers(
      {required String companyId, required List<AppUser> companyUsers}) async {
    final res = await cloudFirestoreRepository.getCompanyInvitations(
        firstCollectionName: FirestoreCollection.companies,
        firstDocId: companyId,
        secondCollectionName: FirestoreCollection.invitations);
    return res.fold((l) => [], (r) {
      List<AppUser> companyInvitations = [];
      for (var doc in r.docs) {
        final data = doc.data();
        data['created_at'] = Timestamp.fromMicrosecondsSinceEpoch(
            DateTime.tryParse(doc.data()['created_at'])
                    ?.microsecondsSinceEpoch ??
                DateTime.now().microsecondsSinceEpoch);

        AppUser user = AppUser.fromJson(data);
        user.invitationId = doc.id;
        companyInvitations.add(user);
      }
      for (AppUser user in companyUsers) {
        companyInvitations
            .removeWhere((element) => element.email == user.email);
      }
      companyInvitations.addAll(companyUsers);
      return companyInvitations;
    });
  }
}
