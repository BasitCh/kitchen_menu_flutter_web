import 'package:json_annotation/json_annotation.dart';

part 'preparation_step.g.dart';

@JsonSerializable(
  createToJson: true,
)
class PreparationStep {
  PreparationStep({
    this.orderNo,
    this.description,
  });

  factory PreparationStep.fromJson(Map<String, dynamic> json) =>
      _$PreparationStepFromJson(json);

  @JsonKey(name: 'order_no')
  int? orderNo;
  String? description;

  Map<String, dynamic> toJson() => _$PreparationStepToJson(this);
}
