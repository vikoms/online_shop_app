import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:online_shop_app/data/exception/dio_exception_handler.dart';
import 'package:online_shop_app/data/exception/server_exception.dart';

import '../model/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getProducts(String category);
  Future<List<String>> getCategories();
  Future<ProductModel> getProductById(int id);
}

class ProductDataSourceImpl implements ProductDataSource {
  final Dio dio;
  ProductDataSourceImpl(this.dio);
  @override
  Future<List<ProductModel>> getProducts(String category) async {
    try {
      String url = '/products';
      category.isNotEmpty ? url += '/category/$category' : url += '';
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final products = response.data as List<dynamic>;
        return products.map((data) => ProductModel.fromJson(data)).toList();
      } else {
        throw ServerException("Unknwon Error");
      }
    } on DioError catch (error) {
      // throw ServerException(
      //     "Status Code : ${error.response?.statusCode} Error : ${error.response?.statusMessage}");
      throw ServerException(DioExceptionHandler.handleException(error));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      final response = await dio.get('/products/categories');
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data.map((item) => item.toString()).toList();
      } else {
        throw ServerException("Unknwon Error");
      }
    } on DioError catch (error) {
      throw ServerException(DioExceptionHandler.handleException(error));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await dio.get('/products/$id');
      if (response.statusCode == 200) {
        final product = response.data;
        return ProductModel.fromJson(product);
      } else {
        throw ServerException("Unknwon Error");
      }
    } on DioError catch (error) {
      // throw ServerException(
      //     "Status Code : ${error.response?.statusCode} Error : ${error.response?.statusMessage}");
      throw ServerException(DioExceptionHandler.handleException(error));
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
