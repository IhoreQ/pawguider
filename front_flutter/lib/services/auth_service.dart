import 'package:dio/dio.dart';
import 'package:front_flutter/dio/dio_config.dart';

class AuthService {
  final Dio _dio = DioConfig.createDio();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      Response response = await _dio.post(
        '/auth/authenticate',
        data: {
          'email': email,
          'password': password
        },
      );
      return response.data;
    } on DioException catch (e) {
      return e.response!.data;
    }
  }
}