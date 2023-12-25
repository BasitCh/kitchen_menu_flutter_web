import 'package:widgets_book/widgets_book.dart';

part 'child.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Child {
  @JsonKey(name: 'child_id')
  String? childId;
  @JsonKey(name: 'child_name')
  final String? childName;
  @JsonKey(name: 'room_name')
  final String? roomName;
  @JsonKey(name: 'center_name')
  final String? centerName;
  final List<String>? allergies;
  @JsonKey(name: 'additional_notes')
  final String? additionalNotes;
  @JsonKey(name: 'weekly-attendance')
  final List<String>? weeklyAttendance;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'company_id')
  final String? companyId;
  @JsonKey(name: 'company_name')
  final String? companyName;

  Child({
    this.childId,
    this.childName,
    this.roomName,
    this.centerName,
    this.allergies,
    this.additionalNotes,
    this.createdAt,
    this.companyId,
    this.companyName,
    this.weeklyAttendance
  });

  factory Child.fromJson(Map<String, dynamic> json) => _$ChildFromJson(json);

  Map<String, dynamic> toJson() => _$ChildToJson(this);
}
