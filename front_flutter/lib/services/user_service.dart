import 'package:dio/dio.dart';
import 'package:front_flutter/utilities/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../dio/dio_config.dart';
import '../models/user.dart';

class UserService {
  final Dio _dio = DioConfig.createDio();

  Future<User?> getCurrentUser() async {
    try {
      Response response = await _dio.get('/user',);
      Map<String, dynamic> rawData = response.data;
      User user = _getUserFromData(rawData);

      return user;
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        return null;
      }
      rethrow;
    }
  }

  Future<void> updatePosition(LatLng newPosition) async {
    try {
      Response response = await _dio.patch(
        '/user/location',
        data: {
          "latitude": newPosition.latitude,
          "longitude": newPosition.longitude
        }
      );

      return response.data;
    } on DioException {
      rethrow;
    }
  }

  Future<dynamic> getUserById(int userId) async {
    try {
      Response response = await _dio.get(
        '/user/$userId'
      );

      Map<String, dynamic> rawData = response.data;
      User user = _getUserFromData(rawData);

      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return 404;
      } else {
        return null;
      }
    }
  }

  User _getUserFromData(Map<String, dynamic> rawData) {
    return User(
        rawData['id'],
        rawData['firstName'],
        rawData['lastName'],
        Constants.imageServerUrl + rawData['photoName'],
        rawData['cityId'],
        rawData['cityName'],
        rawData['phone'],
        rawData['email'],
        rawData['gender'],
        rawData['dogsCount']
    );
  }

  Future<bool> updatePassword(String oldPassword, String newPassword) async {
    try {
      Response response = await _dio.patch(
        '/user/password',
        data: {
          'oldPassword': oldPassword,
          'newPassword': newPassword
        }
      );
      return response.data;
    } on DioException {
      rethrow;
    }
  }
}