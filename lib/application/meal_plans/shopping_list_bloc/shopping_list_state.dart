part of 'shopping_list_bloc.dart';

abstract class ShoppingListState extends Equatable {
  const ShoppingListState();
}

class ShoppingListInitialState extends ShoppingListState {
  @override
  List<Object> get props => [];
}

// class ShoppingListLoadingState extends ShoppingListState {
//   @override
//   List<Object> get props => [];
// }

class ShoppingListLoadedState extends ShoppingListState {
  const ShoppingListLoadedState({
    required this.ingredients,
    this.totalPrice = 0.0,
  });

  final List<Ingredient> ingredients;
  final double? totalPrice;

  @override
  List<Object> get props => [
        ingredients,
      ];
}

class ShoppingListErrorState extends ShoppingListState {
  const ShoppingListErrorState({required this.message});

  final String message;

  @override
  List<Object> get props => [
        message,
      ];
}
