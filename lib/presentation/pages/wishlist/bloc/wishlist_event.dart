part of 'wishlist_bloc.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class OnGetWishlistEvent extends WishlistEvent {
  const OnGetWishlistEvent();

  @override
  List<Object> get props => [];
}
