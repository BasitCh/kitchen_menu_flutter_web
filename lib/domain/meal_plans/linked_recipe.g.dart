// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linked_recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LinkedRecipe _$LinkedRecipeFromJson(Map<String, dynamic> json) => LinkedRecipe(
      id: json['id'] as String?,
      name: json['name'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$LinkedRecipeToJson(LinkedRecipe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
    };
