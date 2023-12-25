part of 'shopping_list_bloc.dart';

abstract class ShoppingListEvent extends Equatable {
  const ShoppingListEvent();
}

class FetchShoppingListEvent extends ShoppingListEvent {
  const FetchShoppingListEvent({required this.recipes,});
  final List<Recipe> recipes;
  @override
  List<Object?> get props => [recipes,];
}

class AddQuantityShoppingListEvent extends ShoppingListEvent {
  const AddQuantityShoppingListEvent({required this.ingredient,});
  final Ingredient ingredient;
  @override
  List<Object?> get props => [ingredient,];
}

class SubtractQuantityShoppingListEvent extends ShoppingListEvent {
  const SubtractQuantityShoppingListEvent({required this.ingredient,});
  final Ingredient ingredient;
  @override
  List<Object?> get props => [ingredient,];
}

class RemoveIngredient extends ShoppingListEvent {
  final Ingredient ingredient;

  const RemoveIngredient({required this.ingredient});
  @override
  List<Object?> get props => [
        ingredient,
      ];
}

class ClearShoppingListEvent extends ShoppingListEvent {
  const ClearShoppingListEvent();



  @override
  List<Object?> get props => [];
}
