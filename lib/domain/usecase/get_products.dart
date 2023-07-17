import 'package:dartz/dartz.dart';
import 'package:online_shop_app/domain/entities/product.dart';
import 'package:online_shop_app/domain/repositories/product_repository.dart';
import 'package:online_shop_app/utils/failure.dart';

class GetProducts {
  final ProductRepository repository;
  GetProducts(this.repository);

  Future<Either<Failure, List<Product>>> execute(String category) async {
    return await repository.getProducts(category);
  }
}
