// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => $checkedCreate(
      'AppUser',
      json,
      ($checkedConvert) {
        final val = AppUser(
          id: $checkedConvert('id', (v) => v as String?),
          email: $checkedConvert('email', (v) => v as String?),
          imageUrl: $checkedConvert('image_url', (v) => v as String?),
          firstName: $checkedConvert('first_name', (v) => v as String?),
          lastName: $checkedConvert('last_name', (v) => v as String?),
          fullName: $checkedConvert('full_name', (v) => v as String?),
          phoneNumber: $checkedConvert('phone_number', (v) => v as String?),
          address: $checkedConvert(
              'address',
              (v) => v == null
                  ? null
                  : UserAddress.fromJson(v as Map<String, dynamic>)),
          isEmailVerified:
              $checkedConvert('is_email_verified', (v) => v as bool?),
          subscriptionType:
              $checkedConvert('subscription_type', (v) => v as String?),
          subscriptionStatus:
              $checkedConvert('subscription_status', (v) => v as String?),
          userRole: $checkedConvert('user_role', (v) => v as String?),
          chefRole: $checkedConvert('chef_role', (v) => v as String?),
          about: $checkedConvert('about', (v) => v as String?),
          companyId: $checkedConvert('company_id', (v) => v as String?),
          companyName: $checkedConvert('company_name', (v) => v as String?),
          createdAt: $checkedConvert(
              'created_at', (v) => dateFromJson(v as Timestamp?)),
          stripeCustomerId:
              $checkedConvert('stripe_customer_id', (v) => v as String?),
          stripePriceId:
              $checkedConvert('stripe_price_id', (v) => v as String?),
          stripeProductId:
              $checkedConvert('stripe_product_id', (v) => v as String?),
          subscriptionId:
              $checkedConvert('subscription_id', (v) => v as String?),
          isDeleted: $checkedConvert('is_deleted', (v) => v as bool? ?? false),
          invitedBy: $checkedConvert('invited_by', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'imageUrl': 'image_url',
        'firstName': 'first_name',
        'lastName': 'last_name',
        'fullName': 'full_name',
        'phoneNumber': 'phone_number',
        'isEmailVerified': 'is_email_verified',
        'subscriptionType': 'subscription_type',
        'subscriptionStatus': 'subscription_status',
        'userRole': 'user_role',
        'chefRole': 'chef_role',
        'companyId': 'company_id',
        'companyName': 'company_name',
        'createdAt': 'created_at',
        'stripeCustomerId': 'stripe_customer_id',
        'stripePriceId': 'stripe_price_id',
        'stripeProductId': 'stripe_product_id',
        'subscriptionId': 'subscription_id',
        'isDeleted': 'is_deleted',
        'invitedBy': 'invited_by'
      },
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('email', instance.email);
  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('full_name', instance.fullName);
  writeNotNull('image_url', instance.imageUrl);
  writeNotNull('phone_number', instance.phoneNumber);
  writeNotNull('address', instance.address?.toJson());
  writeNotNull('is_email_verified', instance.isEmailVerified);
  writeNotNull('subscription_type', instance.subscriptionType);
  writeNotNull('subscription_status', instance.subscriptionStatus);
  writeNotNull('about', instance.about);
  writeNotNull('user_role', instance.userRole);
  writeNotNull('chef_role', instance.chefRole);
  writeNotNull('company_id', instance.companyId);
  writeNotNull('company_name', instance.companyName);
  writeNotNull('created_at', dateToJson(instance.createdAt));
  writeNotNull('subscription_id', instance.subscriptionId);
  writeNotNull('stripe_product_id', instance.stripeProductId);
  writeNotNull('stripe_customer_id', instance.stripeCustomerId);
  writeNotNull('stripe_price_id', instance.stripePriceId);
  writeNotNull('is_deleted', instance.isDeleted);
  writeNotNull('invited_by', instance.invitedBy);
  return val;
}

UserAddress _$UserAddressFromJson(Map<String, dynamic> json) => UserAddress(
      countryName: json['country_name'] as String?,
      state: json['state'] as String?,
      streetAddress: json['street_address'] as String?,
      countryCode: json['country_code'] as String?,
    );

Map<String, dynamic> _$UserAddressToJson(UserAddress instance) =>
    <String, dynamic>{
      'country_name': instance.countryName,
      'state': instance.state,
      'street_address': instance.streetAddress,
      'country_code': instance.countryCode,
    };
