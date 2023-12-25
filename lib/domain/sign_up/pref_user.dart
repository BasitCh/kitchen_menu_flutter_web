import 'package:menumaster_manager/domain/sign_up/app_user.dart';
import 'package:widgets_book/widgets_book.dart';

part 'pref_user.g.dart';

@JsonSerializable(
  checked: true,
  createToJson: true,
  includeIfNull: false,
  explicitToJson: true,
)
class PrefUser {
  final String? id;
  final String? email;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'image_url')
  String? imageUrl;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? password;
  @JsonKey(name: 'phone_number')
  final String? phoneNumber;
  final UserAddress? address;
  @JsonKey(name: 'is_email_verified')
  final bool? isEmailVerified;
  @JsonKey(name: 'subscription_type')
  final String? subscriptionType;
  @JsonKey(name: 'subscription_status')
  final String? subscriptionStatus;
  final String? about;
  @JsonKey(name: 'user_role')
  final String? userRole;
  @JsonKey(name: 'chef_role')
  final String? chefRole;
  @JsonKey(name: 'company_id')
  final String? companyId;
  @JsonKey(name: 'company_name')
  final String? companyName;
  @JsonKey(name: 'subscription_id')
  String? subscriptionId;
  @JsonKey(name: 'stripe_product_id')
  String? stripeProductId;
  @JsonKey(name: 'stripe_customer_id')
  String? stripeCustomerId;
  @JsonKey(name: 'stripe_price_id')
  String? stripePriceId;

  PrefUser({
    this.id,
    this.email,
    this.imageUrl,
    this.firstName,
    this.lastName,
    this.fullName,
    this.phoneNumber,
    this.password,
    this.address,
    this.isEmailVerified,
    this.subscriptionType,
    this.subscriptionStatus,
    this.userRole,
    this.chefRole,
    this.about,
    this.companyId,
    this.companyName,
    this.stripeCustomerId,
    this.stripePriceId,
    this.stripeProductId,
    this.subscriptionId,
  });

  PrefUser copyWith({
    String? id,
    String? email,
    String? fullName,
    String? imageUrl,
    String? password,
    String? phoneNumber,
    String? country,
    String? state,
    String? streetAddress,
    bool? isEmailVerified,
    String? subscription,
    String? about,
    String? firstName,
    String? lastName,
    String? subscriptionStatus,
    String? userRole,
    String? chefRole,
    UserAddress? address,
    String? companyId,
    String? companyName,
    String? subscriptionId,
    String? stripeProductId,
    String? stripeCustomerId,
    String? stripePriceId,
  }) =>
      PrefUser(
          id: id ?? this.id,
          email: email ?? this.email,
          fullName: fullName ?? this.fullName,
          firstName: firstName ?? this.firstName,
          lastName: lastName ?? this.lastName,
          imageUrl: imageUrl ?? this.imageUrl,
          password: password ?? this.password,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          address: address ?? this.address,
          isEmailVerified: isEmailVerified ?? this.isEmailVerified,
          subscriptionType: subscription ?? subscriptionType,
          about: about ?? this.about,
          subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
          userRole: userRole ?? this.userRole,
          chefRole: chefRole ?? this.chefRole,
          companyId: companyId ?? this.companyId,
          companyName: companyName ?? this.companyName,
          stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
          stripePriceId: stripePriceId ?? this.stripePriceId,
          stripeProductId: stripeProductId ?? this.stripeProductId,
          subscriptionId: subscriptionId ?? this.subscriptionId);

  factory PrefUser.fromJson(Map<String, dynamic> json) =>
      _$PrefUserFromJson(json);

  Map<String, dynamic> toJson() => _$PrefUserToJson(this);
}
