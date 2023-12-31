import 'package:online_shop_app/data/db/database_helper.dart';
import 'package:online_shop_app/data/model/wishlist_model.dart';

import '../exception/database_exception.dart';

abstract class WishlistLocalDataSource {
  Future<List<WishListModel>> getWishlist();
  Future<WishListModel?> getWishlistById(int id);
  Future<String> insertWishtlist(WishListModel wishlist);
  Future<String> removeWishlist(int id);
  Future<String> clearWishlist();
}

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  final DatabaseHelper databaseHelper;
  WishlistLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<String> clearWishlist() async {
    try {
      await databaseHelper.clearWishlist();
      return 'Product removed from wishlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<WishListModel>> getWishlist() async {
    try {
      final result = await databaseHelper.getWishlist();
      return result.map((e) => WishListModel.fromMap(e)).toList();
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WishListModel?> getWishlistById(int id) async {
    try {
      final result = await databaseHelper.getWishlistById(id);
      if (result != null) {
        return WishListModel.fromMap(result);
      } else {
        return null;
      }
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> insertWishtlist(WishListModel wishlist) async {
    try {
      await databaseHelper.insertWishlist(wishlist);
      return 'Product added to wishlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWishlist(int id) async {
    try {
      await databaseHelper.removeWishlist(id);
      return 'Product removed from wishlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
