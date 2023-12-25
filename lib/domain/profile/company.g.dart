// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Company _$CompanyFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Company',
      json,
      ($checkedConvert) {
        final val = Company(
          id: $checkedConvert('id', (v) => v as String?),
          userId: $checkedConvert('user_id', (v) => v as String?),
          companyName: $checkedConvert('company_name', (v) => v as String?),
          companyLogo: $checkedConvert('company_logo', (v) => v as String?),
          phoneNumber: $checkedConvert('phone_number', (v) => v as String?),
          address: $checkedConvert(
              'address',
              (v) => v == null
                  ? null
                  : UserAddress.fromJson(v as Map<String, dynamic>)),
          about: $checkedConvert('about', (v) => v as String?),
          createdAt: $checkedConvert(
              'created_at', (v) => dateFromJson(v as Timestamp?)),
        );
        return val;
      },
      fieldKeyMap: const {
        'userId': 'user_id',
        'companyName': 'company_name',
        'companyLogo': 'company_logo',
        'phoneNumber': 'phone_number',
        'createdAt': 'created_at'
      },
    );

Map<String, dynamic> _$CompanyToJson(Company instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_id', instance.userId);
  writeNotNull('company_name', instance.companyName);
  writeNotNull('company_logo', instance.companyLogo);
  writeNotNull('phone_number', instance.phoneNumber);
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('about', instance.about);
  writeNotNull('created_at', dateToJson(instance.createdAt));
  return val;
}
