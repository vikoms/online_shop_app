import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../../utils/wishlist_mapper.dart';
import '../entities/wistlist.dart';
import '../repositories/wishlist_repository.dart';

class InsertWishlist {
  final WishlistRepository repository;
  final WishlistMapper mapper;

  InsertWishlist(
    this.repository,
    this.mapper,
  );

  Future<Either<Failure, String>> execute(Wishlist wishlist) async {
    final wishlistModel = mapper.fromEntity(wishlist);
    return await repository.insertWishlist(wishlistModel);
  }
}
