// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invite _$InviteFromJson(Map<String, dynamic> json) => Invite(
      email: json['email'] as String?,
      fullName: json['full_name'] as String?,
      subscriptionType: json['subscription_type'] as String?,
      subscriptionStatus: json['subscription_status'] as String?,
      userRole: json['user_role'] as String?,
      chefRole: json['chef_role'] as String?,
      companyId: json['company_id'] as String?,
      companyName: json['company_name'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      invitedBy: json['invited_by'] as String?,
      subscriptionId: json['subscription_id'] as String?,
      stripeProductId: json['stripe_product_id'] as String?,
      stripeCustomerId: json['stripe_customer_id'] as String?,
      stripePriceId: json['stripe_price_id'] as String?,
    );

Map<String, dynamic> _$InviteToJson(Invite instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('email', instance.email);
  writeNotNull('full_name', instance.fullName);
  writeNotNull('subscription_type', instance.subscriptionType);
  writeNotNull('subscription_status', instance.subscriptionStatus);
  writeNotNull('user_role', instance.userRole);
  writeNotNull('chef_role', instance.chefRole);
  writeNotNull('company_id', instance.companyId);
  writeNotNull('company_name', instance.companyName);
  writeNotNull('invited_by', instance.invitedBy);
  writeNotNull('subscription_id', instance.subscriptionId);
  writeNotNull('stripe_product_id', instance.stripeProductId);
  writeNotNull('stripe_customer_id', instance.stripeCustomerId);
  writeNotNull('stripe_price_id', instance.stripePriceId);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  return val;
}
