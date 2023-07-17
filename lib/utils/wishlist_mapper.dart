import '../data/model/wishlist_model.dart';
import '../domain/entities/wistlist.dart';

class WishlistMapper {
  WishListModel fromEntity(Wishlist wishlist) => WishListModel(
        id: wishlist.id,
        name: wishlist.name,
        price: wishlist.price,
        photo: wishlist.photo,
      );
}
