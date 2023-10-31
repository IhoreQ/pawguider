import 'package:dio/dio.dart';
import 'package:front_flutter/models/walk.dart';
import 'package:front_flutter/utilities/constants.dart';

import '../dio/dio_config.dart';
import '../models/place.dart';

class WalkService {
  final Dio _dio = DioConfig.createDio();

  Future<Walk?> getActiveWalk() async {
    try {
      Response response = await _dio.get('/walk');

      if (response.data == '') {
        return null;
      }

      Map<String, dynamic> rawData = response.data;
      Place place = Place.walkInfo(rawData['placeId'], rawData['placeName'], Constants.imageServerUrl + rawData['placePhoto'], rawData['placeStreet'], rawData['houseNumber']);
      Walk walk = Walk(rawData['walkId'], rawData['startTime'], place);
      return walk;
    } on DioException {
      rethrow;
    }
  }

  Future<void> deleteWalk() async {
    try {
      Response response = await _dio.delete('/walk');
    } on DioException {
      rethrow;
    }
  }

  Future<bool> addWalk(int placeId) async {
    try {
      Response response = await _dio.post(
        '/walk',
        data: {
            "placeId": placeId
        }
      );
      return true;
    } on DioException {
      return false;
    }
  }

}