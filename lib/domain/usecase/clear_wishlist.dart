import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../repositories/wishlist_repository.dart';

class ClearWishlist {
  final WishlistRepository repository;
  ClearWishlist(this.repository);
  Future<Either<Failure, String>> execute() async {
    return await repository.clearWishlist();
  }
}
