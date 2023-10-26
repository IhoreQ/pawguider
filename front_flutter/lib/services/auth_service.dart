import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:front_flutter/services/basic_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/router.dart';

class AuthService extends BasicService{

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      Response response = await dio.post(
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
      Response response = await dio.post(
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
      Response response = await dio.get(
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

  Future<void> logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('jwtToken');
    if (context.mounted) {
      context.router.pushAndPopUntil(
          const LoginRoute(), predicate: (route) => false);
    }
  }

}