import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/wistlist.dart';
import '../repositories/wishlist_repository.dart';

class GetWishlist {
  final WishlistRepository repository;
  GetWishlist(this.repository);
  Future<Either<Failure, List<Wishlist>>> execute() async {
    return await repository.getWishlist();
  }
}
