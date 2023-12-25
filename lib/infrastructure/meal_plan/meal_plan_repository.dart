// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'package:fpdart/src/either.dart';
import 'package:menumaster_manager/domain/meal_plans/i_meal_plan_repository.dart';
import 'package:menumaster_manager/domain/meal_plans/meal_plan.dart';
import 'package:menumaster_manager/domain/services/cloud_firestore/i_cloud_firestore_repository.dart';
import 'package:widgets_book/widgets_book.dart';

const String startDateConstant = 'start_date';
const String endDateConstant = 'end_date';

class MealPlanRepository implements IMealPlanRepository {
  MealPlanRepository({
    required this.firestoreRepository,
  });

  final ICloudFirestoreRepository firestoreRepository;

  @override
  Future<Either<ApiError, List<MealPlan>>> getMealPlans({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final response = await firestoreRepository.getNestedMealPlanCollection(
      firstCollectionName: FirestoreCollection.users,
      firstDocId: userId,
      secondCollectionName: FirestoreCollection.mealPlans,
      firstWhereKey: startDateConstant,
      firstWhereValue: startDate,
      secondWhereKey: endDateConstant,
      secondWhereValue: endDate,
      orderBy: 'created_at',
    );
    return response.fold((l) => left(l.toApiError()),
        (QuerySnapshot<Map<String, dynamic>> r) {
      List<MealPlan> mealPlans = [];
      for (var doc in r.docs) {
        var dynamicList = doc.data()['data'];
        dynamicList.forEach((element) {
          MealPlan plan = MealPlan.fromJson(doc.id, element);
          plan.id = doc.id;
          mealPlans.add(plan);
        });
      }
      return right(
        mealPlans,
      );
    });
  }
}
