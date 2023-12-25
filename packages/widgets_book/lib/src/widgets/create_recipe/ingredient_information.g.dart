// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IngredientInformationNutritionWeightPerServing
    _$IngredientInformationNutritionWeightPerServingFromJson(
            Map<String, dynamic> json) =>
        IngredientInformationNutritionWeightPerServing(
          amount: (json['amount'] as num?)?.toDouble(),
          unit: json['unit'] as String?,
        );

Map<String, dynamic> _$IngredientInformationNutritionWeightPerServingToJson(
        IngredientInformationNutritionWeightPerServing instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'unit': instance.unit,
    };

IngredientInformationNutritionNutrients
    _$IngredientInformationNutritionNutrientsFromJson(
            Map<String, dynamic> json) =>
        IngredientInformationNutritionNutrients(
          amount: (json['amount'] as num?)?.toDouble(),
          name: json['name'] as String?,
          percentOfDailyNeeds:
              (json['percentOfDailyNeeds'] as num?)?.toDouble(),
          unit: json['unit'] as String?,
        );

Map<String, dynamic> _$IngredientInformationNutritionNutrientsToJson(
        IngredientInformationNutritionNutrients instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'name': instance.name,
      'percentOfDailyNeeds': instance.percentOfDailyNeeds,
      'unit': instance.unit,
    };

IngredientInformationNutrition _$IngredientInformationNutritionFromJson(
        Map<String, dynamic> json) =>
    IngredientInformationNutrition(
      nutrients: (json['nutrients'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : IngredientInformationNutritionNutrients.fromJson(
                  e as Map<String, dynamic>))
          .toList(),
      weightPerServing: json['weightPerServing'] == null
          ? null
          : IngredientInformationNutritionWeightPerServing.fromJson(
              json['weightPerServing'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IngredientInformationNutritionToJson(
        IngredientInformationNutrition instance) =>
    <String, dynamic>{
      'nutrients': instance.nutrients?.map((e) => e?.toJson()).toList(),
      'weightPerServing': instance.weightPerServing?.toJson(),
    };

IngredientInformationEstimatedCost _$IngredientInformationEstimatedCostFromJson(
        Map<String, dynamic> json) =>
    IngredientInformationEstimatedCost(
      unit: json['unit'] as String?,
      value: (json['value'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$IngredientInformationEstimatedCostToJson(
        IngredientInformationEstimatedCost instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      'value': instance.value,
    };

IngredientInformation _$IngredientInformationFromJson(
        Map<String, dynamic> json) =>
    IngredientInformation(
      aisle: json['aisle'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      categoryPath: (json['categoryPath'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      estimatedCost: json['estimatedCost'] == null
          ? null
          : IngredientInformationEstimatedCost.fromJson(
              json['estimatedCost'] as Map<String, dynamic>),
      id: (json['id'] as num?)?.toDouble(),
      image: json['image'] as String?,
      name: json['name'] as String?,
      nutrition: json['nutrition'] == null
          ? null
          : IngredientInformationNutrition.fromJson(
              json['nutrition'] as Map<String, dynamic>),
      original: json['original'] as String?,
      originalName: json['originalName'] as String?,
      possibleUnits: (json['possibleUnits'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      shoppingListUnits: (json['shoppingListUnits'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
    );

Map<String, dynamic> _$IngredientInformationToJson(
        IngredientInformation instance) =>
    <String, dynamic>{
      'aisle': instance.aisle,
      'amount': instance.amount,
      'categoryPath': instance.categoryPath,
      'estimatedCost': instance.estimatedCost?.toJson(),
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'nutrition': instance.nutrition?.toJson(),
      'original': instance.original,
      'originalName': instance.originalName,
      'possibleUnits': instance.possibleUnits,
      'shoppingListUnits': instance.shoppingListUnits,
    };
