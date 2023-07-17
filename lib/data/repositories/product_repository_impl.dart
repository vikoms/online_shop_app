import 'package:online_shop_app/data/datasources/product_data_source.dart';
import 'package:online_shop_app/domain/entities/category.dart';
import 'package:online_shop_app/utils/failure.dart';

import 'package:online_shop_app/domain/entities/product.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/product_repository.dart';
import '../exception/server_exception.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductDataSource dataSource;
  ProductRepositoryImpl({required this.dataSource});
  @override
  Future<Either<Failure, List<Product>>> getProducts(String category) async {
    try {
      final result = await dataSource.getProducts(category);
      return Right(result.map((product) => product.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final result = await dataSource.getCategories();
      return Right(result.map((category) => Category(name: category)).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Product>> getProductById(int id) async {
    try {
      final product = await dataSource.getProductById(id);
      return Right(product.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
