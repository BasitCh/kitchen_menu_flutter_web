// ignore_for_file: depend_on_referenced_packages, implementation_imports

import 'package:fpdart/src/either.dart';
import 'package:menumaster_manager/domain/meal_plans/i_all_recipes_repository.dart';
import 'package:menumaster_manager/domain/meal_plans/recipe.dart';
import 'package:menumaster_manager/domain/services/cloud_firestore/i_cloud_firestore_repository.dart';
import 'package:widgets_book/widgets_book.dart';

class AllRecipesRepository implements IRecipesRepository {
  AllRecipesRepository({
    required this.cloudFirestoreRepository,
  });

  final ICloudFirestoreRepository cloudFirestoreRepository;

  @override
  Future<Either<ApiError, Recipe>> getRecipe({
    required String recipeId,
  }) async {
    final response = await cloudFirestoreRepository.getDocument(
      collectionName: FirestoreCollection.recipes,
      docId: recipeId,
    );
    return response.fold(
      (l) => left(
        l.toApiError(),
      ),
      (docSnapshot) {
        Recipe recipe = Recipe.fromJson(
          docSnapshot.data() ?? {},
        );
        recipe.id = docSnapshot.id;
        return right(recipe);
      },
    );
  }
}
