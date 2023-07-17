import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_shop_app/domain/usecase/get_product_by_id.dart';

import '../../../../domain/entities/product.dart';
import '../../../../domain/entities/wistlist.dart';
import '../../../../domain/usecase/get_wishlist.dart';
import '../../../../domain/usecase/get_wishlist_by_id.dart';
import '../../../../domain/usecase/insert_wishlist.dart';
import '../../../../domain/usecase/remove_wishlist.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductById getProductById;
  final GetWishlistById getWishlistById;
  final GetWishlist getWishlist;
  final InsertWishlist insertWishlist;
  final RemoveWishlist removeWishlist;

  ProductDetailBloc({
    required this.getProductById,
    required this.getWishlist,
    required this.getWishlistById,
    required this.removeWishlist,
    required this.insertWishlist,
  }) : super(ProductDetailInitial()) {
    on<GetProductEvent>((event, emit) async {
      emit(ProductDetailLoading());
      var result = await getProductById.execute(event.id);
      var isWishlist = await checkIsWishlist(event.id);
      result.fold((error) {
        emit(ProductDetailError(error.message));
      }, (product) {
        emit(ProductDetailLoaded(product, isWishlist: isWishlist));
      });
    });

    on<SelectSizeEvent>((event, emit) {
      if (state is ProductDetailLoaded) {
        emit((state as ProductDetailLoaded).copyWith(
          size: event.name,
          isWishlist: (state as ProductDetailLoaded).isWishlist,
        ));
      }
    });

    on<AddWishlistEvent>((event, emit) async {
      if (state is ProductDetailLoaded) {
        var product = (state as ProductDetailLoaded).product;
        var wishlist = Wishlist(
          id: product.id,
          name: product.title,
          photo: product.imageUrl,
          price: product.price.toString(),
        );
        var result = await insertWishlist.execute(wishlist);
        result.fold(
            (error) => print(error.message),
            (result) => emit(
                (state as ProductDetailLoaded).copyWith(isWishlist: true)));
      }
    });

    on<RemoveWishlistEvent>((event, emit) async {
      if (state is ProductDetailLoaded) {
        var result = await removeWishlist.execute(event.id);
        result.fold(
            (error) => print(error.message),
            (result) => emit(
                (state as ProductDetailLoaded).copyWith(isWishlist: false)));
      }
    });
  }

  Future<bool> checkIsWishlist(int id) async {
    var wishlist = await getWishlistById.execute(id);
    bool isWishlist = false;
    wishlist.fold(
        (l) => isWishlist = false, (wishlist) => isWishlist = wishlist != null);
    return isWishlist;
  }
}
