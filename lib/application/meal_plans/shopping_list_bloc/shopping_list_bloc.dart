import 'dart:async';

import 'package:menumaster_manager/domain/meal_plans/recipe.dart';
import 'package:widgets_book/widgets_book.dart';
part 'shopping_list_event.dart';
part 'shopping_list_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListBloc() : super(ShoppingListInitialState()) {
    on<FetchShoppingListEvent>(_onFetchShoppingListEvent);
    on<ClearShoppingListEvent>(_onClearShoppingListEvent);
    on<AddQuantityShoppingListEvent>(_onAddQuantityShoppingListEvent);
    on<SubtractQuantityShoppingListEvent>(_onSubtractQuantityShoppingListEvent);
    on<RemoveIngredient>(_onRemoveIngredient);
  }

  Map<String, Ingredient> localIngredients = {};
  List<Ingredient> ingredients = [];

  Future<void> _onFetchShoppingListEvent(
      FetchShoppingListEvent event, Emitter<ShoppingListState> emit) async {
    ingredients.clear();
    emit(ShoppingListInitialState());
    /*
    To get shopping list first of all we have to get all the [recipes] which
    include [ingredients] through event [FetchShoppingListEvent]
    */
    for (int j = 0; j < event.recipes.length; j++) {
      Recipe recipe = event.recipes[j];
      if (recipe.ingredients != null) {
        for (int i = 0; i < recipe.ingredients!.length; i++) {
          Ingredient ingredient = recipe.ingredients![i];
          ingredient = ingredient.copyWith(
            numberOfChildren: recipe.noOfMealPlanChildren,
            price: ingredient.price ?? 0,
          );
          ingredients.add(ingredient);
        }
      }
    }

    ingredients = mergeIngredients(ingredients);
    final totalPrice = totalPriceSum;
    emit(
      ShoppingListLoadedState(
        ingredients: ingredients,
        totalPrice: totalPrice,
      ),
    );
  }

  List<Ingredient> mergeIngredients(List<Ingredient> ingredients) {
    List<Ingredient> shoppingList = [];

    for (Ingredient ingredient in ingredients) {
      bool found = false;

      // Iterate through the existing shopping list to check for duplicates
      for (int i = 0; i < shoppingList.length; i++) {
        Ingredient existingIngredient = shoppingList[i];

        if (ingredient.name == existingIngredient.name &&
            ingredient.unit == existingIngredient.unit) {
          // If an ingredient with the same id and name exists, update its unit
          int previousChildren = existingIngredient.numberOfChildren ?? 0;
          int children = ingredient.numberOfChildren ?? 0;
          int numberOfChildren = previousChildren + children;

          existingIngredient =
              calculateQuantityAndPrice(existingIngredient, ingredient);
          shoppingList[i] = Ingredient(
            id: existingIngredient.id,
            name: existingIngredient.name,
            quantity: existingIngredient.quantity,
            unit: existingIngredient.unit,
            price: existingIngredient.price,
            // You can choose how to handle unit conflicts
            numberOfChildren: numberOfChildren,
          );
          found = true;
          break;
        }
      }

      if (!found) {
        Ingredient calculatedIngredient =
            calculateQuantityAndPrice(null, ingredient);
        // If no matching ingredient was found in the shopping list, add the new ingredient
        shoppingList.add(calculatedIngredient);
      }
    }

    return shoppingList;
  }

  Ingredient calculateQuantityAndPrice(
      Ingredient? existingIngredient, Ingredient ingredient) {
    if (existingIngredient != null) {
      if (ingredient.quantity != null && ingredient.quantity!.contains('/')) {
        List<String> tempStrings = ingredient.quantity!.split('/');
        double value1 = double.parse(tempStrings[0]);
        double value2 = double.parse(tempStrings[1]);
        double quantity =
            double.parse(existingIngredient.quantity!) + (value1 / value2);
        double numberOfMealPlanChildren =
            (ingredient.numberOfChildren ?? 0).toDouble() +
                existingIngredient.numberOfChildren!;
        if (numberOfMealPlanChildren > 0) {
          double quantityPerChild = quantity / 10.0;
          double totalQuantity = quantityPerChild * numberOfMealPlanChildren;
          if (existingIngredient.price != null &&
              existingIngredient.price! > 0) {
            var price = existingIngredient.price ?? 0;
            double perUnitPrice = price / quantity;
            double updatedPrice = totalQuantity * perUnitPrice;
            ingredient = ingredient.copyWith(
              quantity: totalQuantity.toStringAsFixed(1),
              price: updatedPrice,
            );
          } else {
            ingredient = ingredient.copyWith(
              quantity: totalQuantity.toStringAsFixed(1),
            );
          }
        }
      } else {
        double quantity = double.parse(ingredient.quantity!);
        double numberOfRecipeChildren =
            (ingredient.numberOfChildren ?? 0).toDouble();
        double existingChildren =
            (existingIngredient.numberOfChildren ?? 0).toDouble();
        double numberOfMealPlanChildren =
            (ingredient.numberOfChildren ?? 0).toDouble() + existingChildren;
        if (numberOfRecipeChildren > 0 && numberOfMealPlanChildren > 0) {
          double quantityPerChild =
              quantity / numberOfRecipeChildren.toDouble();
          double totalQuantity = quantityPerChild * numberOfMealPlanChildren;
          if (ingredient.price != null && ingredient.price! > 0) {
            var price = ingredient.price ?? 0;
            double perUnitPrice = price / quantity;
            double updatedPrice = totalQuantity * perUnitPrice;
            ingredient = ingredient.copyWith(
              quantity: totalQuantity.toStringAsFixed(1),
              price: updatedPrice,
              numberOfChildren: ingredient.numberOfChildren,
            );
          } else {
            ingredient = ingredient.copyWith(
              quantity: totalQuantity.toStringAsFixed(1),
              numberOfChildren: ingredient.numberOfChildren,
            );
          }
        }
      }
      if (ingredient.quantity != null) {
        double quantity = double.parse(ingredient.quantity!) / 10;
        double price = (ingredient.price ?? 0) / 10;
        int children = ingredient.numberOfChildren ?? 0;
        double updatedQuantity = quantity * children.toDouble();
        double updatedPrice = price * children.toDouble();
        ingredient = ingredient.copyWith(
          quantity: updatedQuantity.toStringAsFixed(1),
          price: updatedPrice,
        );
      }
    } else {
      if (ingredient.quantity != null && ingredient.quantity!.contains('/')) {
        List<String> tempStrings = ingredient.quantity!.split('/');
        double value1 = double.parse(tempStrings[0]);
        double value2 = double.parse(tempStrings[1]);
        double quantity = (value1 / value2);
        double numberOfMealPlanChildren =
            (ingredient.numberOfChildren ?? 0).toDouble();
        if (numberOfMealPlanChildren > 0) {
          double quantityPerChild = quantity / 10.0;
          double totalQuantity = quantityPerChild * numberOfMealPlanChildren;
          if (ingredient.price != null && ingredient.price! > 0) {
            var price = ingredient.price ?? 0;
            double perUnitPrice = price / quantity;
            double updatedPrice = totalQuantity * perUnitPrice;
            ingredient = ingredient.copyWith(
              quantity: totalQuantity.toStringAsFixed(1),
              price: updatedPrice,
            );
          } else {
            ingredient = ingredient.copyWith(
              quantity: totalQuantity.toStringAsFixed(1),
            );
          }
        }
      } else {
        double quantity = double.parse(ingredient.quantity!);
        // double numberOfRecipeChildren =
        //     (ingredient.numberOfChildren ?? 0).toDouble();
        double numberOfMealPlanChildren =
            (ingredient.numberOfChildren ?? 0).toDouble();
        // print('Recipe children: $numberOfRecipeChildren');
        if (numberOfMealPlanChildren > 0) {
          double quantityPerChild =
              quantity / numberOfMealPlanChildren.toDouble();
          double totalQuantity = quantityPerChild * numberOfMealPlanChildren;
          if (ingredient.price != null && ingredient.price! > 0) {
            var price = ingredient.price ?? 0;
            double perUnitPrice = price / quantity;
            double updatedPrice = totalQuantity * perUnitPrice;
            ingredient = ingredient.copyWith(
              quantity: totalQuantity.toStringAsFixed(1),
              price: updatedPrice,
              numberOfChildren: ingredient.numberOfChildren,
            );
          } else {
            ingredient = ingredient.copyWith(
              quantity: totalQuantity.toStringAsFixed(1),
              numberOfChildren: ingredient.numberOfChildren,
            );
          }
        }
      }
      if (ingredient.quantity != null) {
        double quantity = double.parse(ingredient.quantity!) / 10;
        double price = (ingredient.price ?? 0) / 10;
        int children = ingredient.numberOfChildren ?? 0;
        double updatedQuantity = quantity * children.toDouble();
        double updatedPrice = price * children.toDouble();
        ingredient = ingredient.copyWith(
          quantity: updatedQuantity.toStringAsFixed(1),
          price: updatedPrice,
        );
      }
    }
    return ingredient;
  }

  Future<void> _onRemoveIngredient(
      RemoveIngredient event, Emitter<ShoppingListState> emit) async {
    emit(ShoppingListInitialState());
    int index = ingredients.indexWhere((element) =>
        element.name == event.ingredient.name &&
        element.unit == event.ingredient.unit);
    ingredients.removeAt(index);
    final totalPrice = totalPriceSum;
    emit(
      ShoppingListLoadedState(
        ingredients: ingredients.toList(),
        totalPrice: totalPrice,
      ),
    );
  }

  Future<void> _onClearShoppingListEvent(
      ClearShoppingListEvent event, Emitter<ShoppingListState> emit) async {
    ingredients.clear();
    emit(ShoppingListInitialState());
  }

  Future<void> _onAddQuantityShoppingListEvent(
      AddQuantityShoppingListEvent event,
      Emitter<ShoppingListState> emit) async {
    emit(ShoppingListInitialState());
    try {
      /*
        Get [index] in [localIngredients] where the [ingredient] (from event)
        exists.
      */
      int index = ingredients.indexWhere((element) =>
          element.name == event.ingredient.name &&
          element.unit == event.ingredient.unit);
      /*
      * simplify ingredient type.
      * */
      Ingredient ingredient = event.ingredient;
      /*
          To convert ingredient's [quantity] into [double]
          we must remove slashes
      * */
      if (ingredient.quantity!.contains('/')) {
        List<String> tempStrings = ingredient.quantity!.split('/');
        double value1 = double.parse(tempStrings[0]);
        double value2 = double.parse(tempStrings[1]);
        ingredient = ingredient.copyWith(quantity: '${value1 / value2}');
      }

      /*
      * Calculating the [price per unit] by diving the the number of items
      * with the price
      * */

      double perUnitPrice =
          event.ingredient.price! / double.parse(ingredient.quantity!);
      double updatedQuantity = double.parse(ingredient.quantity!) + 0.5;
      double updatedPrice = updatedQuantity * perUnitPrice;
      /*
      *     Replacing the actual [ingredient] with updated [ingredient]
      */
      ingredient = ingredient.copyWith(
        quantity: updatedQuantity.toString(),
        price: updatedPrice,
      );
      ingredients[index] = ingredient;
      // print(localIngredients.values.toList()[index].toJson());
    } catch (e) {
    } finally {
      final totalPrice = totalPriceSum;
      emit(ShoppingListLoadedState(
        ingredients: ingredients.toList(),
        totalPrice: totalPrice,
      ));
    }
  }

  Future<void> _onSubtractQuantityShoppingListEvent(
      SubtractQuantityShoppingListEvent event,
      Emitter<ShoppingListState> emit) async {
    emit(ShoppingListInitialState());
    try {
      /*
        Get [index] in [localIngredients] where the [ingredient] (from event)
        exists.
      */
      int index = ingredients.indexWhere((element) =>
          element.name == event.ingredient.name &&
          element.unit == event.ingredient.unit);
      /*
      * simplify ingredient type.
      */
      Ingredient ingredient = event.ingredient;
      /*
          To convert ingredient's [quantity] into [double]
          we must remove slashes
      * */
      if (ingredient.quantity!.contains('/')) {
        List<String> tempStrings = ingredient.quantity!.split('/');
        double value1 = double.parse(tempStrings[0]);
        double value2 = double.parse(tempStrings[1]);
        ingredient = ingredient.copyWith(quantity: '${value1 / value2}');
      }
      /*
        The value must not go in negative -ve, so we must put a
        check to not go any further
      */
      if (double.parse(ingredient.quantity!) > 0.5) {
        double updatedQuantity = double.parse(ingredient.quantity!) - 0.5;
        /*
      * Calculating the [price per unit] by diving the the number of items
      * with the price
      * */

        double perUnitPrice =
            ingredient.price! / double.parse(ingredient.quantity!);
        double updatedPrice = updatedQuantity * perUnitPrice;
        ingredient = ingredient.copyWith(
          quantity: updatedQuantity.toString(),
          price: updatedPrice,
        );
        /*
          Replacing the actual [ingredient] with updated [ingredient]
        */
        ingredients[index] = ingredient;
        // print(localIngredients.values.toList()[index].toJson());
      } else if (double.parse(ingredient.quantity!) == 0.5) {
        ingredients
            .removeWhere((value) => value.name == event.ingredient.name!);
      }
    } catch (e) {
    } finally {
      final totalPrice = totalPriceSum;
      emit(ShoppingListLoadedState(
        ingredients: ingredients,
        totalPrice: totalPrice,
      ));
    }
  }

  double get totalPriceSum {
    final totalItemsPrice = ingredients.map((e) => e.price ?? 0.0);
    return totalItemsPrice.fold(0.0, (sum, item) {
      return sum + item;
    });
  }
}
