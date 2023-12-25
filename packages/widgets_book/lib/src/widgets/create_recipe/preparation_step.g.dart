// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preparation_step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreparationStep _$PreparationStepFromJson(Map<String, dynamic> json) =>
    PreparationStep(
      orderNo: json['order_no'] as int?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$PreparationStepToJson(PreparationStep instance) =>
    <String, dynamic>{
      'order_no': instance.orderNo,
      'description': instance.description,
    };
