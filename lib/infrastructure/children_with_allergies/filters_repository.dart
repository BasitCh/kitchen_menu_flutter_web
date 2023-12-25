// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'package:fpdart/src/either.dart';
import 'package:menumaster_manager/domain/children_with_allergies/filters.dart';
import 'package:menumaster_manager/domain/children_with_allergies/i_filters_repository.dart';
import 'package:menumaster_manager/domain/services/cloud_firestore/i_cloud_firestore_repository.dart';
import 'package:menumaster_manager/infrastructure/services/shared_preferences_helper.dart';
import 'package:widgets_book/widgets_book.dart';

Map<String, List<String>> newAllergies = {
  'allergies': [
    'Dairy',
    'Eggs',
    'Wheat',
    'Gluten',
    'Barley',
    'Rye',
    'Fish',
    'Shellfish',
    'Canned Fish',
    'Nuts',
    'Tree Nuts',
    'Sesame',
    'Soybeans'
  ]
};

class FiltersRepository extends IFiltersRepository {
  final ICloudFirestoreRepository cloudFirestoreRepository;

  FiltersRepository({required this.cloudFirestoreRepository});

  @override
  Future<Either<ApiError, Filters>> getAllergies() async {
    final appUser = await SharedPreferenceService.getUser();
    final response = await cloudFirestoreRepository.getCompanyAllergies(
      collectionName: FirestoreCollection.companies,
      docId: appUser?.companyId ?? '',
      innerCollectionName: FirestoreCollection.settings,
      innerDocId: FirestoreCollection.allergies,
    );
    return response.fold(
      (l) => left(
        l.toApiError(),
      ),
      (DocumentSnapshot<Map<String, dynamic>> documentSnapshot) async {
        // if allergies does not exist then add allergies to company
        if (documentSnapshot.exists) {
          Filters filters = Filters.fromJson(documentSnapshot.data() ?? {});
          // this is to check if old user has old allergies the update it
          final allergies = filters.data?.values.first ?? [];
          if (allergies.isNotEmpty) {
            if (!allergies.contains('Nuts') ||
                !allergies.contains('Soybeans')) {
              final response = await uploadCompanyAllergies(
                  companyId: appUser?.companyId ?? '');
              Filters filters = Filters.fromJson(response.data() ?? {});
              return right(filters);
            } else {
              return right(filters);
            }
          } else {
            return right(filters);
          }
        } else {
          final response =
              await uploadCompanyAllergies(companyId: appUser?.companyId ?? '');
          Filters filters = Filters.fromJson(response.data() ?? {});
          return right(filters);
        }
        //
      },
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> uploadCompanyAllergies(
      {required String companyId}) async {
    Map<String, dynamic> data = {};

    data['data'] = newAllergies;
    final response = await cloudFirestoreRepository.uploadCompanyAllergies(
        collectionName: FirestoreCollection.companies,
        docId: companyId,
        innerCollectionName: FirestoreCollection.settings,
        innerDocId: FirestoreCollection.allergies,
        object: data);
    return response;
  }

  @override
  Future<void> addAllergy({required List<String> allergies}) async {
    final appUser = await SharedPreferenceService.getUser();
    Map<String, dynamic> data = {};
    Map<String, List<String>> allergiesMap = {'allergies': allergies};
    data['data'] = allergiesMap;
    return await cloudFirestoreRepository.updateCompanyAllergies(
        collectionName: FirestoreCollection.companies,
        docId: appUser?.companyId ?? '',
        innerCollectionName: FirestoreCollection.settings,
        innerDocId: FirestoreCollection.allergies,
        object: data);
  }

  @override
  Future<void> createWeeklyAttendance({required List<String> days}) async {
    final appUser = await SharedPreferenceService.getUser();
    Map<String, dynamic> data = {};
    Map<String, List<String>> weekDays = {'week-days': days};
    data['data'] = weekDays;
    return await cloudFirestoreRepository.uploadWeeklyAttendance(
        collectionName: FirestoreCollection.companies,
        docId: appUser?.companyId ?? '',
        innerCollectionName: FirestoreCollection.settings,
        innerDocId: FirestoreCollection.weekDays,
        object: data);
  }

  @override
  Future<Either<ApiError, List<String>>> getWeeklyAttendance() async {
    final appUser = await SharedPreferenceService.getUser();
    List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday'
    ];

    final response = await cloudFirestoreRepository.getWeekDays(
      collectionName: FirestoreCollection.companies,
      docId: appUser?.companyId ?? '',
      innerCollectionName: FirestoreCollection.settings,
      innerDocId: FirestoreCollection.weekDays,
    );
    return response.fold(
      (l) => left(
        l.toApiError(),
      ),
      (DocumentSnapshot<Map<String, dynamic>> documentSnapshot) async {
        if (documentSnapshot.exists) {
          Filters filters = Filters.fromJson(documentSnapshot.data() ?? {});
          final days = filters.data?.values.first.toSet().toList();
          return right(days!);
        } else {
          await createWeeklyAttendance(days: days);
          return right(days);
        }
        //
      },
    );
  }
}
