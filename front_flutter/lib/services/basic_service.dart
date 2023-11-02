import 'package:dio/dio.dart';
import 'package:front_flutter/exceptions/api_error.dart';
import 'package:front_flutter/strings.dart';

import '../dio/dio_config.dart';
import '../exceptions/result.dart';

class BasicService {
  final Dio _dio = DioConfig.createDio();

  Dio get dio => _dio;

  Future<Result<T, ApiError>> handleRequest<T>(Future<T> Function() requestFunction) async {
    try {
      T result = await requestFunction();
      return Success(result);
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.badResponse:
          return Failure(ApiError(e.response!.data['message']));
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return Failure(ApiError(ErrorStrings.timeout));
        case DioExceptionType.connectionError:
          return Failure(ApiError(ErrorStrings.checkInternetConnection));
        default:
          return Failure(ApiError(ErrorStrings.defaultError));
      }
    } on Exception {
      return Failure(ApiError(ErrorStrings.defaultError));
    }
  }
}