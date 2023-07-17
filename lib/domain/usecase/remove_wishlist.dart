import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../repositories/wishlist_repository.dart';

class RemoveWishlist {
  final WishlistRepository repository;
  RemoveWishlist(this.repository);
  Future<Either<Failure, String>> execute(int id) async {
    return await repository.removeWishlist(id);
  }
}
