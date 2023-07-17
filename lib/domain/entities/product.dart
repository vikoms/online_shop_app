class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final RatingEntity rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.imageUrl,
    required this.rating,
  });
}

class RatingEntity {
  final double rate;
  final int count;

  RatingEntity({
    required this.rate,
    required this.count,
  });
}
