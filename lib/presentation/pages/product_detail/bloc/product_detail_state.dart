part of 'product_detail_bloc.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();

  @override
  List<Object> get props => [];
}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

class ProductDetailError extends ProductDetailState {
  String error;
  ProductDetailError(this.error);

  @override
  List<Object> get props => [error];
}

class ProductDetailLoaded extends ProductDetailState {
  Product product;
  List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  String selectedSize;
  bool isWishlist;

  ProductDetailLoaded(this.product,
      {this.selectedSize = 'S', this.isWishlist = false});

  ProductDetailLoaded copyWith({
    String? size,
    bool? isWishlist,
  }) =>
      ProductDetailLoaded(
        product,
        selectedSize: size ?? selectedSize,
        isWishlist: isWishlist ?? this.isWishlist,
      );

  @override
  List<Object> get props => [
        product,
        selectedSize,
        isWishlist,
      ];
}
