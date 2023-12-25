// ignore_for_file: depend_on_referenced_packages, implementation_imports
import 'package:fpdart/src/either.dart';
import 'package:menumaster_manager/domain/meal_plans/company_allergies.dart';
import 'package:menumaster_manager/domain/meal_plans/i_company_allergies_repository.dart';
import 'package:menumaster_manager/domain/services/cloud_firestore/i_cloud_firestore_repository.dart';
import 'package:widgets_book/widgets_book.dart';

class CompanyAllergiesRepository implements ICompanyAllergiesRepository {
  CompanyAllergiesRepository({
    required this.firestoreRepository,
  });

  final ICloudFirestoreRepository firestoreRepository;

  @override
  Future<Either<ApiError, CompanyAllergies>> getCompanyAllergies({
    required String companyId,
  }) async {
    final response = await firestoreRepository.getNestedDocument(
      firstCollectionName: FirestoreCollection.companies,
      firstDocId: companyId,
      secondCollectionName: FirestoreCollection.settings,
      secondDocId: FirestoreDocuments.allergies,
    );
    return response.fold((l) => left(l.toApiError()), (r) {
      CompanyAllergies allergies = CompanyAllergies.fromJson(
        r.data() ?? {},
      );
      return right(allergies);
    });
  }
}
