import 'package:equatable/equatable.dart';

class Wishlist extends Equatable {
  final int id;
  final String name;
  final String price;
  final String photo;

  Wishlist({
    required this.id,
    required this.name,
    required this.price,
    required this.photo,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        photo,
      ];
}
