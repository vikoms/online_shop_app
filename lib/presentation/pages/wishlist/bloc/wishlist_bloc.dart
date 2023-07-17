import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_shop_app/domain/entities/wistlist.dart';
import 'package:online_shop_app/domain/usecase/get_wishlist.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final GetWishlist getWishlist;
  WishlistBloc({
    required this.getWishlist,
  }) : super(WishlistInitial()) {
    on<OnGetWishlistEvent>((event, emit) async {
      emit(WishlistLoading());
      var result = await getWishlist.execute();
      result.fold((error) {
        emit(WishlistError(error.message));
      }, (wishlist) {
        emit(WishlistLoaded(wishlist));
      });
    });
  }
}
