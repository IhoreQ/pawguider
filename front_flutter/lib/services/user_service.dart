import 'package:dio/dio.dart';
import 'package:front_flutter/services/basic_service.dart';
import 'package:front_flutter/services/dto/user/user_update_request.dart';
import 'package:front_flutter/strings.dart';
import 'package:front_flutter/utilities/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../exceptions/api_error.dart';
import '../exceptions/result.dart';
import '../models/user.dart';

class UserService  extends BasicService {
  final String path = '/user';

  Future<Result<User, ApiError>> getCurrentUser() async {
    return await handleRequest(() async {
      Response response = await dio.get(path);

      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> rawData = response.data;
          User user = _getUserFromData(rawData);
          return user;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<int, ApiError>> updatePosition(LatLng newPosition) async {
    return await handleRequest(() async {
      Response response = await dio.patch(
          '$path/location',
          data: {
            "latitude": newPosition.latitude,
            "longitude": newPosition.longitude
          }
      );

      switch (response.statusCode) {
        case 200:
          return response.statusCode!;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<User, ApiError>> getUserById(int userId) async {
    return await handleRequest(() async {
      Response response = await dio.get('$path/$userId');

      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> rawData = response.data;
          User user = _getUserFromData(rawData);

          return user;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
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

  Future<Result<int, ApiError>> updatePassword(String oldPassword, String newPassword) async {
    return await handleRequest(() async {
      Response response = await dio.patch(
          '$path/password',
          data: {
            'oldPassword': oldPassword,
            'newPassword': newPassword
          }
      );

      switch (response.statusCode) {
        case 200:
          return response.statusCode!;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<int, ApiError>> updateUserPhoto(String photoName) async {
    return await handleRequest(() async {
      Response response = await dio.patch(
          '$path/photo',
          data: {
            "photoName": photoName
          }
      );

      switch (response.statusCode) {
        case 200:
          return response.statusCode!;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<int, ApiError>> updateUser(UserUpdateRequest request) async {
    return await handleRequest(() async {
      Response response = await dio.put(
          '$path/details',
          data: request.toJson()
      );

      switch (response.statusCode) {
        case 200:
          return response.statusCode!;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }
}