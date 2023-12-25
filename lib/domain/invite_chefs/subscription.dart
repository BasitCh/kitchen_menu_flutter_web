import 'package:menumaster_manager/domain/invite_chefs/items.dart';
import 'package:widgets_book/widgets_book.dart';

part 'subscription.g.dart';

@JsonSerializable(explicitToJson: true)
class Subscription {
  String? id;
  String? customer;
  Items? items;

  Subscription({
    this.id,
    this.customer
  });

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}
