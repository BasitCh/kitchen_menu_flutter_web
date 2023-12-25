// ignore_for_file: depend_on_referenced_packages
import 'package:fpdart/fpdart.dart';
import 'package:menumaster_manager/domain/meal_plans/recipe.dart';
import 'package:widgets_book/widgets_book.dart';

abstract class IRecipesRepository {
  Future<Either<ApiError, Recipe>> getRecipe({
    required String recipeId,
  });
}
