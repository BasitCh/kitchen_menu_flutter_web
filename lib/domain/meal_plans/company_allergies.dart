import 'package:json_annotation/json_annotation.dart';

part 'company_allergies.g.dart';

@JsonSerializable(explicitToJson: true)
class CompanyAllergies {
  CompanyAllergies({
    this.data,
  });

  CompanyAllergyData? data;

  factory CompanyAllergies.fromJson(Map<String, dynamic> json) =>
      _$CompanyAllergiesFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyAllergiesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CompanyAllergyData {
  CompanyAllergyData({
    this.allergies,
  });

  List<String>? allergies;

  factory CompanyAllergyData.fromJson(Map<String, dynamic> json) =>
      _$CompanyAllergyDataFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyAllergyDataToJson(this);
}
