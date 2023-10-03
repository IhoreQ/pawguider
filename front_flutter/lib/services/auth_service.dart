import 'package:dio/dio.dart';
import 'package:front_flutter/dio/dio_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      return {'error': 'DioError occurred', 'details': e.toString()};
    }
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> details) async {
    try {
      Response response = await _dio.post(
        '/auth/signup',
        data: details
      );
      return {'created': response.data};
    } on DioException catch (e) {
      return {'error': 'DioError occurred', 'details': e.toString()};
    }
  }

  Future<bool> userExists(String email) async {
    try {
      Response response = await _dio.get(
        '/auth/user-exists',
        data: {'email': email}
      );

      return false;
    } on DioException catch (e) {
      if (e.response!.statusCode == 409) {
        return true;
      }
      rethrow;
    }
  }

  Future<bool> isAuthenticated() async {
    String? jwtToken = await getToken();
    return jwtToken != null;
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jwtToken = preferences.getString('jwtToken');

    return jwtToken;
  }

  // TODO refresh token
}