import 'package:dartz/dartz.dart';
import 'package:online_shop_app/domain/repositories/product_repository.dart';

import '../../utils/failure.dart';
import '../entities/product.dart';

class GetProductById {
  final ProductRepository repository;
  GetProductById(this.repository);
  Future<Either<Failure, Product>> execute(int id) async {
    return await repository.getProductById(id);
  }
}
