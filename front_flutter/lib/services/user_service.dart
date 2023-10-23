import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
}