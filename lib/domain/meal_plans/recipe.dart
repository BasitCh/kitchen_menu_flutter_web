import 'dart:io';
import 'package:menumaster_manager/domain/meal_plans/food_category.dart';
import 'package:menumaster_manager/domain/meal_plans/recipe_image.dart';
import 'package:widgets_book/widgets_book.dart';

import 'linked_recipe.dart';

part 'recipe.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: true)
class Recipe {
  Recipe({
    this.id,
    this.name,
    this.description,
    this.images,
    this.cookTime,
    this.prepareTime,
    this.createdAt,
    this.foodCategory,
    this.ingredients,
    this.preparationSteps,
    this.imagesFiles,
    this.filters,
    this.createdBy,
    this.linkedRecipe,
    this.addedBy,
    this.companyId,
    this.noOfRecipeChildren,
    this.noOfMealPlanChildren,
  });

  Recipe copyWith({
    String? id,
    String? name,
    String? description,
    List<RecipeImage>? images,
    String? cookTime,
    String? prepareTime,
    DateTime? createdAt,
    List<FoodCategory>? foodCategory,
    List<Ingredient>? ingredients,
    List<PreparationStep>? preparationSteps,
    List<File?>? imagesFiles,
    List<String>? filters,
    String? createdBy,
    LinkedRecipe? linkedRecipe,
    String? addedBy,
    String? companyId,
    int? noOfRecipeChildren,
    int? noOfMealPlanChildren
  }) =>
      Recipe(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        images: images ?? this.images,
        cookTime: cookTime ?? this.cookTime,
        prepareTime: prepareTime ?? this.prepareTime,
        createdAt: createdAt ?? this.createdAt,
        foodCategory: foodCategory ?? this.foodCategory,
        ingredients: ingredients ?? this.ingredients,
        preparationSteps: preparationSteps ?? this.preparationSteps,
        imagesFiles: imagesFiles ?? this.imagesFiles,
        filters: filters ?? this.filters,
        createdBy: createdBy ?? this.createdBy,
        linkedRecipe: linkedRecipe ?? this.linkedRecipe,
        addedBy: addedBy ?? this.addedBy,
        companyId: companyId ?? this.companyId,
          noOfRecipeChildren:noOfRecipeChildren?? this.noOfRecipeChildren,
          noOfMealPlanChildren:noOfMealPlanChildren?? this.noOfMealPlanChildren
      );

  String? id;
  final String? name;
  final String? description;
  final List<RecipeImage>? images;
  @JsonKey(name: 'cook_time')
  final String? cookTime;
  @JsonKey(name: 'prepare_time')
  final String? prepareTime;
  @JsonKey(
    name: 'created_at',
    toJson: dateToJson,
    fromJson: dateFromJson,
  )
  final DateTime? createdAt;
  @JsonKey(name: 'category')
  final List<FoodCategory>? foodCategory;
  final List<Ingredient>? ingredients;
  @JsonKey(name: 'preparation_steps')
  final List<PreparationStep>? preparationSteps;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final List<File?>? imagesFiles;
  final List<String>? filters;
  @JsonKey(name: 'created_by')
  final String? createdBy;
  @JsonKey(name: 'linked_recipe')
  final LinkedRecipe? linkedRecipe;
  @JsonKey(name: 'added_by')
  final String? addedBy;
  @JsonKey(name: 'company_id')
  final String? companyId;
  @JsonKey(name: 'no_of_children')
  final int? noOfRecipeChildren;
  @JsonKey(includeToJson: false, includeFromJson: false)
  final int? noOfMealPlanChildren;

  // factory Recipe.fromJson(String id, Map<String, dynamic> json) =>
  //     _$RecipeFromJson(json)..id = id;

  factory Recipe.fromJson(Map<String, dynamic> json) =>
      _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
