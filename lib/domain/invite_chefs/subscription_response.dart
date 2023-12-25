import 'package:menumaster_manager/domain/invite_chefs/subscription.dart';
import 'package:widgets_book/widgets_book.dart';

part 'subscription_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SubscriptionResponse {
  String? object;
  List<Subscription>? data;
  bool? hasMore;
  String? url;

  SubscriptionResponse({
    this.object,
    this.data,
    this.hasMore,
    this.url,
  });

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionResponseToJson(this);
}
