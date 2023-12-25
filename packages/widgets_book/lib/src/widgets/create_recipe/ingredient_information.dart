import 'package:widgets_book/widgets_book.dart';

part 'ingredient_information.g.dart';

@JsonSerializable()
class IngredientInformationNutritionWeightPerServing {

  IngredientInformationNutritionWeightPerServing({
    this.amount,
    this.unit,
  });

  factory IngredientInformationNutritionWeightPerServing.fromJson(
          Map<String, dynamic> json) =>
      _$IngredientInformationNutritionWeightPerServingFromJson(json);
/*
{
  "amount": 905,
  "unit": "g"
}
*/

  double? amount;
  String? unit;

  Map<String, dynamic> toJson() =>
      _$IngredientInformationNutritionWeightPerServingToJson(this);
}

@JsonSerializable()
class IngredientInformationNutritionNutrients {

  IngredientInformationNutritionNutrients({
    this.amount,
    this.name,
    this.percentOfDailyNeeds,
    this.unit,
  });

  factory IngredientInformationNutritionNutrients.fromJson(
          Map<String, dynamic> json) =>
      _$IngredientInformationNutritionNutrientsFromJson(json);
/*
{
  "amount": 0.12,
  "name": "Mono Unsaturated Fat",
  "percentOfDailyNeeds": 0,
  "unit": "g"
}
*/

  IngredientInformationNutritionNutrients copyWith({
    double? amount,
    String? name,
    double? percentOfDailyNeeds,
    String? unit,
})=>IngredientInformationNutritionNutrients(
    amount:  amount ?? this.amount,
    name: name ?? this.name,
    percentOfDailyNeeds: percentOfDailyNeeds?? this.percentOfDailyNeeds,
    unit: unit ?? this.unit,
  );


  double? amount;
  String? name;
  double? percentOfDailyNeeds;
  String? unit;

  Map<String, dynamic> toJson() =>
      _$IngredientInformationNutritionNutrientsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class IngredientInformationNutrition {

  IngredientInformationNutrition({
    this.nutrients,
    this.weightPerServing,
  });

  factory IngredientInformationNutrition.fromJson(Map<String, dynamic> json) =>
      _$IngredientInformationNutritionFromJson(json);
/*
{
  "nutrients": [
    {
      "amount": 0.12,
      "name": "Mono Unsaturated Fat",
      "percentOfDailyNeeds": 0,
      "unit": "g"
    }
  ],
  "weightPerServing": {
    "amount": 905,
    "unit": "g"
  }
}
*/

  List<IngredientInformationNutritionNutrients?>? nutrients;
  IngredientInformationNutritionWeightPerServing? weightPerServing;

  Map<String, dynamic> toJson() => _$IngredientInformationNutritionToJson(this);
}

@JsonSerializable(explicitToJson: true)
class IngredientInformationEstimatedCost {

  IngredientInformationEstimatedCost({
    this.unit,
    this.value,
  });

  factory IngredientInformationEstimatedCost.fromJson(
          Map<String, dynamic> json) =>
      _$IngredientInformationEstimatedCostFromJson(json);
/*
{
  "unit": "US Cents",
  "value": 299
}
*/

  String? unit;
  double? value;

  Map<String, dynamic> toJson() =>
      _$IngredientInformationEstimatedCostToJson(this);
}

@JsonSerializable(explicitToJson: true)
class IngredientInformation {

  IngredientInformation({
    this.aisle,
    this.amount,
    this.categoryPath,
    this.estimatedCost,
    this.id,
    this.image,
    this.name,
    this.nutrition,
    this.original,
    this.originalName,
    this.possibleUnits,
    this.shoppingListUnits,
  });

  factory IngredientInformation.fromJson(Map<String, dynamic> json) =>
      _$IngredientInformationFromJson(json);
/*
{
  "aisle": "Produce",
  "amount": 1,
  "categoryPath": [
    "tropical fruit"
  ],
  "estimatedCost": {
    "unit": "US Cents",
    "value": 299
  },
  "id": 9266,
  "image": "pineapple.jpg",
  "name": "pineapples",
  "nutrition": {
    "nutrients": [
      {
        "amount": 0.12,
        "name": "Mono Unsaturated Fat",
        "percentOfDailyNeeds": 0,
        "unit": "g"
      }
    ],
    "weightPerServing": {
      "amount": 905,
      "unit": "g"
    }
  },
  "original": "pineapples",
  "originalName": "pineapples",
  "possibleUnits": [
    "piece"
  ],
  "shoppingListUnits": [
    "pieces"
  ]
}
*/

  String? aisle;
  double? amount;
  List<String?>? categoryPath;
  IngredientInformationEstimatedCost? estimatedCost;
  double? id;
  String? image;
  String? name;
  IngredientInformationNutrition? nutrition;
  String? original;
  String? originalName;
  List<String?>? possibleUnits;
  List<String?>? shoppingListUnits;

  Map<String, dynamic> toJson() => _$IngredientInformationToJson(this);
}
