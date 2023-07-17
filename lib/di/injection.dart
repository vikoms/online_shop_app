import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:online_shop_app/config/dio_config.dart';
import 'package:online_shop_app/data/datasources/firebase_auth_data_source.dart';
import 'package:online_shop_app/data/datasources/product_data_source.dart';
import 'package:online_shop_app/data/datasources/wishlist_local_data_source.dart';
import 'package:online_shop_app/data/db/database_helper.dart';
import 'package:online_shop_app/data/repositories/product_repository_impl.dart';
import 'package:online_shop_app/domain/repositories/authentication_repository.dart';
import 'package:online_shop_app/domain/repositories/product_repository.dart';
import 'package:online_shop_app/domain/repositories/wishlist_repository.dart';
import 'package:online_shop_app/domain/usecase/clear_wishlist.dart';
import 'package:online_shop_app/domain/usecase/get_product_by_id.dart';
import 'package:online_shop_app/domain/usecase/get_products.dart';
import 'package:online_shop_app/domain/usecase/get_wishlist.dart';
import 'package:online_shop_app/domain/usecase/get_wishlist_by_id.dart';
import 'package:online_shop_app/domain/usecase/insert_wishlist.dart';
import 'package:online_shop_app/domain/usecase/remove_wishlist.dart';
import 'package:online_shop_app/domain/usecase/sign_in.dart';
import 'package:online_shop_app/domain/usecase/sign_up.dart';
import 'package:online_shop_app/presentation/pages/home/bloc/home_bloc.dart';
import 'package:online_shop_app/presentation/pages/product_detail/bloc/product_detail_bloc.dart';
import 'package:online_shop_app/presentation/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:online_shop_app/presentation/pages/wishlist/bloc/wishlist_bloc.dart';
import 'package:online_shop_app/utils/wishlist_mapper.dart';

import '../data/repositories/authentication_repository_impl.dart';
import '../data/repositories/wishlist_repository_impl.dart';
import '../domain/usecase/get_categories.dart';

final locator = GetIt.instance;
void init() {
  // BLoC
  locator.registerFactory(
    () => HomeBloc(
      getProducts: locator(),
      getCategories: locator(),
    ),
  );
  locator.registerFactory(
    () => SignInBloc(
      signIn: locator(),
    ),
  );
  locator.registerFactory(
    () => WishlistBloc(
      getWishlist: locator(),
    ),
  );

  locator.registerFactory(
    () => ProductDetailBloc(
      getProductById: locator(),
      getWishlist: locator(),
      getWishlistById: locator(),
      insertWishlist: locator(),
      removeWishlist: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(
    () => GetProducts(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetCategories(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => SignIn(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => SignUp(
      locator(),
    ),
  );

  locator.registerLazySingleton(
    () => GetProductById(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => InsertWishlist(
      locator(),
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetWishlist(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => GetWishlistById(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => RemoveWishlist(
      locator(),
    ),
  );
  locator.registerLazySingleton(
    () => ClearWishlist(
      locator(),
    ),
  );

  // repository
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      dataSource: locator(),
    ),
  );

  locator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      locator(),
    ),
  );
  locator.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(
      locator(),
    ),
  );

  // data source
  locator.registerLazySingleton<ProductDataSource>(
    () => ProductDataSourceImpl(
      locator(),
    ),
  );
  locator.registerLazySingleton<FirebaseAuthDataSource>(
    () => FirebaseAuthDataSourceImpl(
      locator(),
    ),
  );

  locator.registerLazySingleton<WishlistLocalDataSource>(
    () => WishlistLocalDataSourceImpl(
      locator(),
    ),
  );

  // firebase
  locator.registerSingleton(FirebaseAuth.instance);

  locator.registerLazySingleton(() => DioConfig().getDio());

  locator.registerLazySingleton(() => WishlistMapper());
  locator.registerLazySingleton(() => DatabaseHelper());
}
