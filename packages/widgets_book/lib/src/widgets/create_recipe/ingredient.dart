import 'package:json_annotation/json_annotation.dart';
import 'package:widgets_book/src/widgets/create_recipe/ingredient_information.dart';

part 'ingredient.g.dart';

@JsonSerializable(explicitToJson: true)
class Ingredient {
  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Ingredient({
    this.id,
    this.name,
    this.quantity,
    this.unit,
    this.price,
    this.information,
    this.numberOfChildren,
  });

  Ingredient copyWith({
    String? id,
    String? name,
    String? quantity,
    String? unit,
    double? price,
    IngredientInformation? information,
    int? numberOfChildren,
  }) =>
      Ingredient(
        id: id ?? this.id,
        name: name ?? this.name,
        quantity: quantity ?? this.quantity,
        unit: unit ?? this.unit,
        price: price ?? this.price,
        information: information ?? this.information,
        numberOfChildren: numberOfChildren?? this.numberOfChildren,
      );

  final String? id;
  final String? name;
  final String? quantity;
  final String? unit;
  final double? price;
  final IngredientInformation? information;
  final int? numberOfChildren;

  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}
