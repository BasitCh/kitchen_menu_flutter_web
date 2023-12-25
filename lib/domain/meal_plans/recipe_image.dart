import 'package:widgets_book/widgets_book.dart';
part 'recipe_image.g.dart';

@JsonSerializable()
class RecipeImage {
  RecipeImage({
    this.id,
    this.url,
  });

  RecipeImage copyWith({
    String? id,
    String? url,
  }) =>
      RecipeImage(
        id: id ?? this.id,
        url: url ?? this.url,
      );

  final String? id;
  final String? url;

  factory RecipeImage.fromJson(Map<String, dynamic> json) =>
      _$RecipeImageFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeImageToJson(this);
}
