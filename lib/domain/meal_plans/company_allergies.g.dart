// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_allergies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyAllergies _$CompanyAllergiesFromJson(Map<String, dynamic> json) =>
    CompanyAllergies(
      data: json['data'] == null
          ? null
          : CompanyAllergyData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CompanyAllergiesToJson(CompanyAllergies instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
    };

CompanyAllergyData _$CompanyAllergyDataFromJson(Map<String, dynamic> json) =>
    CompanyAllergyData(
      allergies: (json['allergies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CompanyAllergyDataToJson(CompanyAllergyData instance) =>
    <String, dynamic>{
      'allergies': instance.allergies,
    };
