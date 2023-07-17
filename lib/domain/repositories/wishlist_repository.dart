import 'package:dartz/dartz.dart';
import 'package:online_shop_app/data/model/wishlist_model.dart';
import 'package:online_shop_app/domain/entities/wistlist.dart';

import '../../utils/failure.dart';

abstract class WishlistRepository {
  Future<Either<Failure, List<Wishlist>>> getWishlist();
  Future<Either<Failure, Wishlist?>> getWishlistById(int id);
  Future<Either<Failure, String>> insertWishlist(WishListModel wishlist);
  Future<Either<Failure, String>> removeWishlist(int id);
  Future<Either<Failure, String>> clearWishlist();
}
