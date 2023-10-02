import 'package:dio/dio.dart';
import 'package:front_flutter/services/auth_service.dart';

import '../dio/dio_config.dart';

class UserService {
  final Dio _dio = DioConfig.createDio();

  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      Response response = await _dio.get('/user',);
      return response.data;
    } on DioException {
      rethrow;
    }
  }
}