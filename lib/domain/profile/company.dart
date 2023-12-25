import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:widgets_book/widgets_book.dart';

part 'company.g.dart';

@JsonSerializable(
  checked: true,
  createToJson: true,
  includeIfNull: false,
  explicitToJson: true,
)
class Company {
  String? id;
  @JsonKey(name: 'user_id')
  String? userId;
  @JsonKey(name: 'company_name')
  final String? companyName;
  @JsonKey(name: 'company_logo')
  String? companyLogo;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final UserAddress? address;
  final String? about;
  @JsonKey(name: 'created_at', toJson: dateToJson, fromJson: dateFromJson)
  DateTime? createdAt;

  Company({
    this.id,
    this.userId,
    this.companyName,
    this.companyLogo,
    this.phoneNumber,
    this.address,
    this.about,
    this.createdAt,
  });

  Company copyWith({
    String? id,
    String? userId,
    String? companyName,
    String? companyLogo,
    String? phoneNumber,
    UserAddress? address,
    String? about,
  }) =>
      Company(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        companyName: companyName ?? this.companyName,
        companyLogo: companyLogo ?? this.companyLogo,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        about: about ?? this.about,
      );

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}
