import 'package:menumaster_manager/domain/invite_chefs/price.dart';
import 'package:widgets_book/widgets_book.dart';

part 'items_datum.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemsDatum {
  String? id;
  String? object;
  dynamic billingThresholds;
  int? created;
  Price? price;
  int? quantity;
  String? subscription;
  List<dynamic>? taxRates;

  ItemsDatum({
    this.id,
    this.object,
    this.billingThresholds,
    this.created,
    this.price,
    this.quantity,
    this.subscription,
    this.taxRates,
  });

  factory ItemsDatum.fromJson(Map<String, dynamic> json) =>
      _$ItemsDatumFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsDatumToJson(this);
}
