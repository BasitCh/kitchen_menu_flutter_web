// ignore_for_file: must_be_immutable

import 'package:menumaster_manager/domain/meal_plans/recipe.dart';
import 'package:widgets_book/widgets_book.dart';

part 'meal_plan.g.dart';

@JsonSerializable(createToJson: true, explicitToJson: true)
class MealPlan extends Equatable {
  MealPlan({
    this.id,
    this.createdAt,
    this.createdBy,
    this.startDate,
    this.endDate,
    this.mealDate,
    this.numberOfChildren,
    this.recipes,
    this.category,
    this.day,
  });

  MealPlan copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? startDate,
          DateTime? endDate,
          String? createdBy,
          DateTime? mealDate,
          int? numberOfChildren,
          List<Recipe>? recipes,
          String? category,
          String? day,
          bool? isExpanded}) =>
      MealPlan(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        createdBy: createdBy ?? this.createdBy,
        mealDate: mealDate ?? this.mealDate,
        numberOfChildren: numberOfChildren ?? this.numberOfChildren,
        recipes: recipes ?? this.recipes,
        category: category ?? this.category,
        day: day ?? this.day,
      );
  String? id;
  @JsonKey(
    name: 'created_at',
    toJson: dateToJson,
    fromJson: dateFromJson,
  )
  DateTime? createdAt;
  @JsonKey(
    name: 'start_date',
    toJson: dateToJson,
    fromJson: dateFromJson,
  )
  DateTime? startDate;
  @JsonKey(
    name: 'end_date',
    toJson: dateToJson,
    fromJson: dateFromJson,
  )
  DateTime? endDate;
  @JsonKey(
    name: 'meal_date',
    toJson: dateToJson,
    fromJson: dateFromJson,
  )
  DateTime? mealDate;
  @JsonKey(
    name: 'created_by',
  )
  String? createdBy;
  @JsonKey(
    name: 'number_of_children',
  )
  int? numberOfChildren;
  List<Recipe>? recipes;
  String? category;
  String? day;

  // factory MealPlan.fromJson(Map<String, dynamic> json) =>
  //     _$MealPlanFromJson(json);

 factory MealPlan.fromJson(String id, Map<String, dynamic> json) =>
      _$MealPlanFromJson(json);

  Map<String, dynamic> toJson() => _$MealPlanToJson(this);

  @override
  List<Object?> get props => [
        id,
        category,
      ];
}