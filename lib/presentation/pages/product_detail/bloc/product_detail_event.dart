part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

class GetProductEvent extends ProductDetailEvent {
  final int id;
  GetProductEvent(this.id);

  @override
  List<Object> get props => [id];
}

class SelectSizeEvent extends ProductDetailEvent {
  final String name;
  SelectSizeEvent(this.name);

  @override
  List<Object> get props => [name];
}

class AddWishlistEvent extends ProductDetailEvent {
  AddWishlistEvent();

  @override
  List<Object> get props => [];
}

class RemoveWishlistEvent extends ProductDetailEvent {
  final int id;
  RemoveWishlistEvent(this.id);

  @override
  List<Object> get props => [id];
}
