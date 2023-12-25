import 'package:menumaster_manager/domain/invite_chefs/items_datum.dart';
import 'package:widgets_book/widgets_book.dart';

part 'items.g.dart';

@JsonSerializable(explicitToJson: true)
class Items {
  String? object;
  List<ItemsDatum>? data;
  bool? hasMore;
  int? totalCount;
  String? url;

  Items({
    this.object,
    this.data,
    this.hasMore,
    this.totalCount,
    this.url,
  });

  factory Items.fromJson(Map<String, dynamic> json) => _$ItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsToJson(this);
}
