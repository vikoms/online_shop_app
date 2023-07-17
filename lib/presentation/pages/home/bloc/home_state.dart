part of 'home_bloc.dart';

class HomeState extends Equatable {
  final RequestState categoryState;
  final RequestState productState;

  final List<Category> categories;
  final List<Product> products;

  final String categoryError;
  final String productError;

  const HomeState({
    this.categoryState = RequestState.Empty,
    this.productState = RequestState.Empty,
    this.categories = const [],
    this.products = const [],
    this.categoryError = '',
    this.productError = '',
  });

  HomeState copyWith({
    RequestState? categoryState,
    RequestState? productState,
    List<Category>? categories,
    List<Product>? products,
    String? categoryError,
    String? productError,
  }) {
    return HomeState(
      categoryState: categoryState ?? this.categoryState,
      productState: productState ?? this.productState,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      categoryError: categoryError ?? this.categoryError,
      productError: productError ?? this.productError,
    );
  }

  @override
  List<Object?> get props => [
        categoryState,
        productState,
        categories,
        products,
        categoryError,
        productError,
      ];
}

class HomeInitial extends HomeState {}
