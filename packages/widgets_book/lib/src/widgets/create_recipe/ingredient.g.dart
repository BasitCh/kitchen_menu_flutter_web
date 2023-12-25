// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      id: json['id'] as String?,
      name: json['name'] as String?,
      quantity: json['quantity'] as String?,
      unit: json['unit'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      information: json['information'] == null
          ? null
          : IngredientInformation.fromJson(
              json['information'] as Map<String, dynamic>),
      numberOfChildren: json['numberOfChildren'] as int?,
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'price': instance.price,
      'information': instance.information?.toJson(),
      'numberOfChildren': instance.numberOfChildren,
    };
