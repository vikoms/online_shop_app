import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/category.dart';
import '../entities/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> getProducts(String category);
  Future<Either<Failure, Product>> getProductById(int id);
  Future<Either<Failure, List<Category>>> getCategories();
}
