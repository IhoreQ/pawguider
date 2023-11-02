import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/services/basic_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../exceptions/api_error.dart';
import '../exceptions/result.dart';
import '../routes/router.dart';
import '../strings.dart';

class AuthService extends BasicService {

  final path = '/auth';

  Future<Result<String, ApiError>> login(String email, String password) async {
      return await handleRequest(() async {
        Response response = await dio.post(
          '$path/authenticate',
          data: {
            'email': email,
            'password': password
          },
        );

        switch (response.statusCode) {
          case 200:
            final jwtToken = response.data['jwtToken'];
            return jwtToken;
          default:
            throw Exception(ErrorStrings.defaultError);
        }
      });
  }

  Future<Result<int, ApiError>> register(Map<String, dynamic> details) async {
    return await handleRequest(() async {
      Response response = await dio.post(
          '$path/register',
          data: details
      );

      switch (response.statusCode) {
        case 201:
          return response.statusCode!;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<bool, ApiError>> userExists(String email) async {
    return await handleRequest(() async {
      Response response = await dio.get(
        '$path/user-exists',
        data: {'email': email}
      );

      switch (response.statusCode) {
        case 200:
          final bool userExists = response.data;
          return userExists;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
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