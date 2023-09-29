import 'package:dio/dio.dart';

abstract class DioConfig {
  static Dio createDio() {
    return Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 5000),
        baseUrl: 'http://10.0.2.2:8080/api/v1'
      )
    );
  }
}