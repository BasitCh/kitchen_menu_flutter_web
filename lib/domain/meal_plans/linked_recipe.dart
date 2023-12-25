import 'package:widgets_book/widgets_book.dart';

part 'linked_recipe.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: true)
class LinkedRecipe {
  LinkedRecipe({
    this.id,
    this.name,
    this.imageUrl,
  });
  String? id;
  final String? name;
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  factory LinkedRecipe.fromJson(Map<String, dynamic> json) =>
      _$LinkedRecipeFromJson(json);

  Map<String, dynamic> toJson() => _$LinkedRecipeToJson(this);
}
