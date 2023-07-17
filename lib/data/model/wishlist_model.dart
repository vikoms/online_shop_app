import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/product.dart';
import '../../domain/entities/wistlist.dart';

class WishListModel extends Equatable {
  final int id;
  final String name;
  final String price;
  final String photo;

  WishListModel({
    required this.id,
    required this.name,
    required this.price,
    required this.photo,
  });

  factory WishListModel.fromProductEntity(Product product) => WishListModel(
        id: product.id,
        name: product.title,
        price: product.price.toString(),
        photo: product.imageUrl,
      );

  factory WishListModel.fromMap(Map<String, dynamic> map) => WishListModel(
        id: map['id'],
        name: map['title'],
        price: map['price'],
        photo: map['photo'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': name,
        'price': price.toString(),
        'photo': photo,
      };

  Wishlist toEntity() => Wishlist(
        id: id,
        name: name,
        price: price,
        photo: photo,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        photo,
      ];
}
