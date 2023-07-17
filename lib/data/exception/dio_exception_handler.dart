import 'package:dio/dio.dart';

class DioExceptionHandler {
  static String handleException(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return "Request cancelled";
      case DioErrorType.connectionTimeout:
        return "Connection timeout";
      case DioErrorType.receiveTimeout:
        return "Receive timeout in connection with API server";
      case DioErrorType.sendTimeout:
        return "Send timeout in connection with API server";
      case DioErrorType.badResponse:
        try {
          final responseCode = error.response?.statusCode ?? -1;
          switch (responseCode) {
            case 400:
              return "Bad request";
            case 401:
              return "Unauthorized request";
            case 403:
              return "Forbidden";
            case 404:
              return "Not found";
            case 500:
              return "Internal server error";
            default:
              return "Received invalid status code: $responseCode";
          }
        } on Exception catch (_) {
          return "Error occurred while reading response";
        }
      case DioErrorType.unknown:
        return "Unexpected error occurred";
      case DioErrorType.badCertificate:
        return "Bad Certificate";
        break;
      case DioErrorType.connectionError:
        return "Connection error";
        break;
    }
  }
}
