// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Child _$ChildFromJson(Map<String, dynamic> json) => Child(
      childId: json['child_id'] as String?,
      childName: json['child_name'] as String?,
      roomName: json['room_name'] as String?,
      centerName: json['center_name'] as String?,
      allergies: (json['allergies'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      additionalNotes: json['additional_notes'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      companyId: json['company_id'] as String?,
      companyName: json['company_name'] as String?,
      weeklyAttendance: (json['weekly-attendance'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ChildToJson(Child instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('child_id', instance.childId);
  writeNotNull('child_name', instance.childName);
  writeNotNull('room_name', instance.roomName);
  writeNotNull('center_name', instance.centerName);
  writeNotNull('allergies', instance.allergies);
  writeNotNull('additional_notes', instance.additionalNotes);
  writeNotNull('weekly-attendance', instance.weeklyAttendance);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('company_id', instance.companyId);
  writeNotNull('company_name', instance.companyName);
  return val;
}
