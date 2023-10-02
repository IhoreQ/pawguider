import 'package:dio/dio.dart';

import '../services/auth_service.dart';

abstract class DioConfig {
  static Dio createDio() {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 5000),
        baseUrl: 'http://10.0.2.2:8080/api/v1',
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) async {
        String? jwtToken = await AuthService().getToken();

        if (jwtToken != null) {
          options.headers['Authorization'] = 'Bearer $jwtToken';
        }

        return handler.next(options);
      },
    ));

    return dio;
  }
}