part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishlistInitial extends WishlistState {}

class WishlistError extends WishlistState {
  final String message;
  WishlistError(this.message);
  @override
  List<Object> get props => [message];
}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<Wishlist> wishlist;
  WishlistLoaded(this.wishlist);

  @override
  List<Object> get props => [wishlist];
}
