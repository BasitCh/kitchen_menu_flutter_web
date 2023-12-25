// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Items _$ItemsFromJson(Map<String, dynamic> json) => Items(
      object: json['object'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ItemsDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: json['hasMore'] as bool?,
      totalCount: json['totalCount'] as int?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ItemsToJson(Items instance) => <String, dynamic>{
      'object': instance.object,
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'hasMore': instance.hasMore,
      'totalCount': instance.totalCount,
      'url': instance.url,
    };
