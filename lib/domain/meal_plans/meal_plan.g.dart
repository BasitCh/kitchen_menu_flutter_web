// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealPlan _$MealPlanFromJson(Map<String, dynamic> json) => MealPlan(
      id: json['id'] as String?,
      createdAt: dateFromJson(json['created_at'] as Timestamp?),
      createdBy: json['created_by'] as String?,
      startDate: dateFromJson(json['start_date'] as Timestamp?),
      endDate: dateFromJson(json['end_date'] as Timestamp?),
      mealDate: dateFromJson(json['meal_date'] as Timestamp?),
      numberOfChildren: json['number_of_children'] as int?,
      recipes: (json['recipes'] as List<dynamic>?)
          ?.map((e) => Recipe.fromJson(e as Map<String, dynamic>))
          .toList(),
      category: json['category'] as String?,
      day: json['day'] as String?,
    );

Map<String, dynamic> _$MealPlanToJson(MealPlan instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': dateToJson(instance.createdAt),
      'start_date': dateToJson(instance.startDate),
      'end_date': dateToJson(instance.endDate),
      'meal_date': dateToJson(instance.mealDate),
      'created_by': instance.createdBy,
      'number_of_children': instance.numberOfChildren,
      'recipes': instance.recipes?.map((e) => e.toJson()).toList(),
      'category': instance.category,
      'day': instance.day,
    };
