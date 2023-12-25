import 'package:widgets_book/widgets_book.dart';

part 'price.g.dart';

@JsonSerializable(explicitToJson: true)
class Price {
  String? id;
  String? object;
  bool? active;
  String? billingScheme;
  int? created;
  String? currency;
  dynamic customUnitAmount;
  bool? livemode;
  dynamic lookupKey;
  dynamic nickname;
  String? product;
  String? taxBehavior;
  dynamic tiersMode;
  dynamic transformQuantity;
  String? type;
  int? unitAmount;
  String? unitAmountDecimal;

  Price({
    this.id,
    this.object,
    this.active,
    this.billingScheme,
    this.created,
    this.currency,
    this.customUnitAmount,
    this.livemode,
    this.lookupKey,
    this.nickname,
    this.product,
    this.taxBehavior,
    this.tiersMode,
    this.transformQuantity,
    this.type,
    this.unitAmount,
    this.unitAmountDecimal,
  });

  factory Price.fromJson(Map<String, dynamic> json) =>
      _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);

}
