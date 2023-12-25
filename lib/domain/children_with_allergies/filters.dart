// ignore_for_file: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'filters.g.dart';

@JsonSerializable(createToJson: true, explicitToJson: true)
class Filters {
  Filters({
    this.data,
  });

  final Map<String, List<String>>? data;

  Filters copyWith({
    Map<String, List<String>>? data,
  }) =>
      Filters(
        data: data ?? this.data,
      );

  factory Filters.fromJson(Map<String, dynamic> json) =>
      _$FiltersFromJson(json);

  Map<String, dynamic> toJson() => _$FiltersToJson(this);
}
