part of 'recipe_detail_bloc.dart';

abstract class RecipeDetailEvent extends Equatable {
  const RecipeDetailEvent();
}

class FetchRecipeDetail extends RecipeDetailEvent {
  const FetchRecipeDetail({
    required this.recipeId,
  });

  final String recipeId;

  @override
  List<Object?> get props => [
        recipeId,
      ];
}
