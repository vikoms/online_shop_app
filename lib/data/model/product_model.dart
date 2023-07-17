import 'package:json_annotation/json_annotation.dart';
import 'package:online_shop_app/domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  @JsonKey(name: 'image')
  final String imageUrl;
  final RatingModel rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  Product toEntity() => Product(
        id: id,
        title: title,
        price: price,
        description: description,
        category: category,
        imageUrl: imageUrl,
        rating: rating.toEntity(),
      );
}

@JsonSerializable()
class RatingModel {
  final double rate;
  final int count;

  RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);

  Map<String, dynamic> toJson() => _$RatingModelToJson(this);

  RatingEntity toEntity() => RatingEntity(count: count, rate: rate);
}
