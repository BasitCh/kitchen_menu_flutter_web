// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodCategory _$FoodCategoryFromJson(Map<String, dynamic> json) => FoodCategory(
      categoryId: json['category_id'] as String?,
      categoryName: json['category_name'] as String?,
      createdAt: dateFromJson(json['created_at'] as Timestamp?),
      isDeleted: json['is_deleted'] as bool?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$FoodCategoryToJson(FoodCategory instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'created_at': dateToJson(instance.createdAt),
      'is_deleted': instance.isDeleted,
      'image_url': instance.imageUrl,
    };
