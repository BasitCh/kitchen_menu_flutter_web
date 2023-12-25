import 'package:widgets_book/widgets_book.dart';

part 'food_category.g.dart';

@JsonSerializable(
  createToJson: true,
)
class FoodCategory {
  FoodCategory({
    this.categoryId,
    this.categoryName,
    this.createdAt,
    this.isDeleted,
    this.imageUrl,
  });

  @JsonKey(name: 'category_id')
  final String? categoryId;
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @JsonKey(
    toJson: dateToJson,
    fromJson: dateFromJson,
    name: 'created_at',
  )
  final DateTime? createdAt;
  @JsonKey(name: 'is_deleted')
  final bool? isDeleted;
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  FoodCategory copyWith({
    String? categoryId,
    String? categoryName,
    DateTime? createdAt,
    bool? isDeleted,
    String? imageUrl,
  }) =>
      FoodCategory(
        categoryId: categoryId ?? this.categoryId,
        categoryName: categoryName ?? this.categoryName,
        createdAt: createdAt ?? this.createdAt,
        imageUrl: imageUrl ?? this.imageUrl,
        isDeleted: isDeleted ?? this.isDeleted,
      );

  factory FoodCategory.fromJson(Map<String, dynamic> json) =>
      _$FoodCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$FoodCategoryToJson(this);
}
