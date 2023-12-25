// ignore_for_file: implementation_imports, depend_on_referenced_packages
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menumaster_manager/domain/meal_plans/recipe.dart';
import 'package:menumaster_manager/infrastructure/meal_plan/all_recipes_repository.dart';
import 'package:widgets_book/src/helper/network/domain/api_error.dart';

part 'recipe_detail_event.dart';
part 'recipe_detail_state.dart';

mixin LinkedRecipeDetailBloc on Bloc<RecipeDetailEvent, RecipeDetailState> {}

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState>
    with LinkedRecipeDetailBloc {
  RecipeDetailBloc({
    required this.allRecipesRepository,
  }) : super(RecipeDetailInitial()) {
    on<FetchRecipeDetail>(_onFetchRecipeDetail);
  }

  final AllRecipesRepository allRecipesRepository;

  Future<void> _onFetchRecipeDetail(
      FetchRecipeDetail event, Emitter<RecipeDetailState> emit) async {
    emit(RecipeDetailLoading());
    final response = await allRecipesRepository.getRecipe(
      recipeId: event.recipeId,
    );

    response.fold(
      (ApiError apiError) => emit(
        RecipeDetailError(
          message: apiError.message ?? 'Error getting recipe',
        ),
      ),
      (Recipe recipe) => emit(
        RecipeDetailLoaded(
          recipe: recipe,
        ),
      ),
    );
  }
}
