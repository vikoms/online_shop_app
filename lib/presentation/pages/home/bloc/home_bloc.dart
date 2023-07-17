import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:online_shop_app/domain/entities/product.dart';
import 'package:online_shop_app/domain/usecase/get_categories.dart';
import 'package:online_shop_app/domain/usecase/get_products.dart';

import '../../../../domain/entities/category.dart';
import '../../../../utils/request_state.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProducts getProducts;
  final GetCategories getCategories;
  HomeBloc({
    required this.getProducts,
    required this.getCategories,
  }) : super(HomeInitial()) {
    on<OnGetProductEvent>((event, emit) async {
      emit(state.copyWith(productState: RequestState.Loading));
      final result = await getProducts.execute(event.category);
      result.fold((error) {
        emit(state.copyWith(
            productError: error.message, productState: RequestState.Error));
      }, (products) {
        emit(state.copyWith(
            products: products, productState: RequestState.Loaded));
      });
    });

    on<OnGetCategoryEvent>((event, emit) async {
      emit(state.copyWith(categoryState: RequestState.Loading));
      final result = await getCategories.execute();
      result.fold((error) {
        emit(state.copyWith(
            categoryError: error.message, categoryState: RequestState.Error));
      }, (categories) {
        categories[0] = Category(name: categories[0].name, isSelected: true);
        emit(state.copyWith(
            categories: categories, categoryState: RequestState.Loaded));
      });
    });

    on<OnSelectedCategoryEvent>((event, emit) {
      if (state.categoryState == RequestState.Loaded) {
        List<Category> categories = state.categories.map((item) {
          if (item.name == event.category) {
            return Category(name: item.name, isSelected: true);
          } else {
            return Category(name: item.name, isSelected: false);
          }
        }).toList();
        emit(state.copyWith(categories: categories));
        add(OnGetProductEvent(event.category));
      }
    });
  }
}
