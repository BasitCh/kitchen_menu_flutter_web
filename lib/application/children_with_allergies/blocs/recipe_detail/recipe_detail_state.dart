part of 'recipe_detail_bloc.dart';

abstract class RecipeDetailState extends Equatable {
  const RecipeDetailState();
}

class RecipeDetailInitial extends RecipeDetailState {
  @override
  List<Object> get props => [];
}

class RecipeDetailLoading extends RecipeDetailState {
  @override
  List<Object> get props => [];
}

class RecipeDetailLoaded extends RecipeDetailState {
  RecipeDetailLoaded({
    required this.recipe,
  });

  final Recipe recipe;

  @override
  List<Object> get props => [
        recipe,
      ];
}

class RecipeDetailError extends RecipeDetailState {
  RecipeDetailError({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [
        message,
      ];
}
