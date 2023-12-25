import 'package:widgets_book/widgets_book.dart';

part 'invite.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Invite {
  final String? email;
  @JsonKey(name: 'full_name')
  final String? fullName;
  @JsonKey(name: 'subscription_type')
  final String? subscriptionType;
  @JsonKey(name: 'subscription_status')
  final String? subscriptionStatus;
  @JsonKey(name: 'user_role')
  final String? userRole;
  @JsonKey(name: 'chef_role')
  final String? chefRole;
  @JsonKey(name: 'company_id')
  final String? companyId;
  @JsonKey(name: 'company_name')
  final String? companyName;
  @JsonKey(name: 'invited_by')
  final String? invitedBy;
  @JsonKey(name: 'subscription_id')
  String? subscriptionId;
  @JsonKey(name: 'stripe_product_id')
  String? stripeProductId;
  @JsonKey(name: 'stripe_customer_id')
  String? stripeCustomerId;
  @JsonKey(name: 'stripe_price_id')
  String? stripePriceId;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  Invite({
    this.email,
    this.fullName,
    this.subscriptionType,
    this.subscriptionStatus,
    this.userRole,
    this.chefRole,
    this.companyId,
    this.companyName,
    this.createdAt,
    this.invitedBy,
    this.subscriptionId,
    this.stripeProductId,
    this.stripeCustomerId,
    this.stripePriceId,
  });

  Invite copyWith({
    String? email,
    String? fullName,
    String? subscription,
    String? about,
    String? firstName,
    String? lastName,
    String? subscriptionStatus,
    String? userRole,
    String? chefRole,
    String? subscriptionId,
    String? stripeProductId,
    DateTime? createdAt,
    String? invitedBy,
    String? stripeCustomerId,
    String? stripePriceId,
  }) =>
      Invite(
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        subscriptionType: subscription ?? subscriptionType,
        subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
        userRole: userRole ?? this.userRole,
        chefRole: chefRole ?? this.chefRole,
        createdAt: createdAt ?? this.createdAt,
        invitedBy: invitedBy ?? this.invitedBy,
        subscriptionId: subscriptionId ?? this.subscriptionId,
        stripeProductId: stripeProductId ?? this.stripeProductId,
        stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
        stripePriceId: stripePriceId ?? this.stripePriceId,
      );

  factory Invite.fromJson(Map<String, dynamic> json) => _$InviteFromJson(json);

  Map<String, dynamic> toJson() => _$InviteToJson(this);
}
