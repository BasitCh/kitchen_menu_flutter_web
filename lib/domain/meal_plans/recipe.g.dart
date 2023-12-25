// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => RecipeImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      cookTime: json['cook_time'] as String?,
      prepareTime: json['prepare_time'] as String?,
      createdAt: dateFromJson(json['created_at'] as Timestamp?),
      foodCategory: (json['category'] as List<dynamic>?)
          ?.map((e) => FoodCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      preparationSteps: (json['preparation_steps'] as List<dynamic>?)
          ?.map((e) => PreparationStep.fromJson(e as Map<String, dynamic>))
          .toList(),
      filters:
          (json['filters'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdBy: json['created_by'] as String?,
      linkedRecipe: json['linked_recipe'] == null
          ? null
          : LinkedRecipe.fromJson(
              json['linked_recipe'] as Map<String, dynamic>),
      addedBy: json['added_by'] as String?,
      companyId: json['company_id'] as String?,
      noOfRecipeChildren: json['no_of_children'] as int?,
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'images': instance.images?.map((e) => e.toJson()).toList(),
      'cook_time': instance.cookTime,
      'prepare_time': instance.prepareTime,
      'created_at': dateToJson(instance.createdAt),
      'category': instance.foodCategory?.map((e) => e.toJson()).toList(),
      'ingredients': instance.ingredients?.map((e) => e.toJson()).toList(),
      'preparation_steps':
          instance.preparationSteps?.map((e) => e.toJson()).toList(),
      'filters': instance.filters,
      'created_by': instance.createdBy,
      'linked_recipe': instance.linkedRecipe?.toJson(),
      'added_by': instance.addedBy,
      'company_id': instance.companyId,
      'no_of_children': instance.noOfRecipeChildren,
    };
