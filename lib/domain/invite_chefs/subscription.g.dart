// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      id: json['id'] as String?,
      customer: json['customer'] as String?,
    )..items = json['items'] == null
        ? null
        : Items.fromJson(json['items'] as Map<String, dynamic>);

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer': instance.customer,
      'items': instance.items?.toJson(),
    };
