// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_datum.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemsDatum _$ItemsDatumFromJson(Map<String, dynamic> json) => ItemsDatum(
      id: json['id'] as String?,
      object: json['object'] as String?,
      billingThresholds: json['billingThresholds'],
      created: json['created'] as int?,
      price: json['price'] == null
          ? null
          : Price.fromJson(json['price'] as Map<String, dynamic>),
      quantity: json['quantity'] as int?,
      subscription: json['subscription'] as String?,
      taxRates: json['taxRates'] as List<dynamic>?,
    );

Map<String, dynamic> _$ItemsDatumToJson(ItemsDatum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'billingThresholds': instance.billingThresholds,
      'created': instance.created,
      'price': instance.price?.toJson(),
      'quantity': instance.quantity,
      'subscription': instance.subscription,
      'taxRates': instance.taxRates,
    };
