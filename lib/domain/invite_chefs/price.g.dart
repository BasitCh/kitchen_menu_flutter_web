// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Price _$PriceFromJson(Map<String, dynamic> json) => Price(
      id: json['id'] as String?,
      object: json['object'] as String?,
      active: json['active'] as bool?,
      billingScheme: json['billingScheme'] as String?,
      created: json['created'] as int?,
      currency: json['currency'] as String?,
      customUnitAmount: json['customUnitAmount'],
      livemode: json['livemode'] as bool?,
      lookupKey: json['lookupKey'],
      nickname: json['nickname'],
      product: json['product'] as String?,
      taxBehavior: json['taxBehavior'] as String?,
      tiersMode: json['tiersMode'],
      transformQuantity: json['transformQuantity'],
      type: json['type'] as String?,
      unitAmount: json['unitAmount'] as int?,
      unitAmountDecimal: json['unitAmountDecimal'] as String?,
    );

Map<String, dynamic> _$PriceToJson(Price instance) => <String, dynamic>{
      'id': instance.id,
      'object': instance.object,
      'active': instance.active,
      'billingScheme': instance.billingScheme,
      'created': instance.created,
      'currency': instance.currency,
      'customUnitAmount': instance.customUnitAmount,
      'livemode': instance.livemode,
      'lookupKey': instance.lookupKey,
      'nickname': instance.nickname,
      'product': instance.product,
      'taxBehavior': instance.taxBehavior,
      'tiersMode': instance.tiersMode,
      'transformQuantity': instance.transformQuantity,
      'type': instance.type,
      'unitAmount': instance.unitAmount,
      'unitAmountDecimal': instance.unitAmountDecimal,
    };
