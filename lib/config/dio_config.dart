import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConfig {
  InterceptorsWrapper getDioInterceptor() {
    return InterceptorsWrapper();
  }

  Dio getDio() {
    Dio dio = Dio();
    BaseOptions options = BaseOptions(
      baseUrl: 'https://fakestoreapi.com',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    dio = Dio(options);

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90),
      );
    }

    return dio;
  }
}
