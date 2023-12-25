import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_book/src/widgets/create_recipe/ingredient.dart';
import 'package:widgets_book/src/widgets/create_recipe/ingredient_information.dart';

class CreateIngredientsCubit extends Cubit<CreateIngredientsCubitState> {
  CreateIngredientsCubit() : super(CreateIngredientsCubitState());

  void initialize(List<Ingredient> ingredients) {
    state
      ..ingredients = ingredients
      ..totalAmount = 0;
    emit(state);
    print('here ${state.ingredients.length}');
    calculateTotalAmount();
    calculateNutrients();
  }

  void addNewIngredient(Ingredient ingredient) {
    List<Ingredient> ingredients = state.ingredients.toList();
    ingredients.add(ingredient);
    emit(
      state.copyWith(
        ingredients: ingredients.toList(),
      ),
    );
    calculateTotalAmount();
    calculateNutrients();
  }

  void removeIngredient(Ingredient ingredient) {
    List<Ingredient> ingredients = state.ingredients.toList();
    ingredients.removeWhere((element) => ingredient.name == element.name);
    emit(
      state.copyWith(
        ingredients: ingredients.toList(),
      ),
    );
    calculateTotalAmount();
    calculateNutrients();
  }

  void calculateTotalAmount() {
    double amount = 0;
    for (int index = 0; index < state.ingredients.length; index++) {
      amount = amount + (state.ingredients[index].price ?? 0);
    }
    emit(
      state.copyWith(totalAmount: amount),
    );
  }

  void calculateNutrients() {
    Map<String, IngredientInformationNutritionNutrients> nutrientsMap = {};
    for (int i = 0; i < state.ingredients.length; i++) {
      Ingredient ingredient = state.ingredients[i];
      List<IngredientInformationNutritionNutrients?>? nutrients =
          ingredient.information?.nutrition?.nutrients;
      if (nutrients != null) {
        double price = ingredient.price==0?1:ingredient.price??1;
        for (int j = 0; j < nutrients.length; j++) {
          IngredientInformationNutritionNutrients? nutrient = nutrients[j];
          if (nutrientsMap.containsKey(nutrient!.name)) {
            IngredientInformationNutritionNutrients? oldNutrient =
                nutrientsMap[nutrient.name!];
            nutrientsMap[nutrient.name!] = nutrient.copyWith(
              percentOfDailyNeeds: (oldNutrient!.percentOfDailyNeeds! +
                      nutrient.percentOfDailyNeeds!) *
                  price,
            );
          } else {
            double price = ingredient.price==0?1:ingredient.price??1;
            nutrientsMap[nutrient.name!] = nutrient.copyWith(
                percentOfDailyNeeds:
                    (nutrient.percentOfDailyNeeds!) * price);
          }
        }
      }
    }
    // nutrientsMap.forEach((key, value) {
    //   print('{Nutrient name: $key: ${value.toJson()}');
    // });

    emit(
      state.copyWith(
        nutrients: nutrientsMap,
      ),
    );
  }

  void reset() {
    emit(CreateIngredientsCubitState());
  }
}

class CreateIngredientsCubitState {
  CreateIngredientsCubitState({
    this.ingredients = const <Ingredient>[],
    this.totalAmount = 0,
    this.nutrients,
  });

  CreateIngredientsCubitState copyWith({
    List<Ingredient>? ingredients,
    double? totalAmount,
    Map<String, IngredientInformationNutritionNutrients>? nutrients,
  }) =>
      CreateIngredientsCubitState(
        ingredients: ingredients ?? this.ingredients,
        totalAmount: totalAmount ?? this.totalAmount,
        nutrients: nutrients ?? this.nutrients,
      );
  List<Ingredient> ingredients;
  Map<String, IngredientInformationNutritionNutrients>? nutrients;
  double? totalAmount;
}
