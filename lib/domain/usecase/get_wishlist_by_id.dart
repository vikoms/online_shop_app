import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/wistlist.dart';
import '../repositories/wishlist_repository.dart';

class GetWishlistById {
  final WishlistRepository repository;

  GetWishlistById(this.repository);

  Future<Either<Failure, Wishlist?>> execute(int id) async {
    return await repository.getWishlistById(id);
  }
}
