import 'package:dio/dio.dart';
import 'package:front_flutter/exceptions/api_error.dart';
import 'package:front_flutter/models/walk.dart';
import 'package:front_flutter/services/basic_service.dart';
import 'package:front_flutter/strings.dart';
import 'package:front_flutter/utilities/constants.dart';

import '../exceptions/result.dart';
import '../models/place/place.dart';

class WalkService extends BasicService {
  final String path = "/walk";

  Future<Result<Walk?, ApiError>> getActiveWalk() async {
    return await handleRequest(() async {
      Response response = await dio.get(path);

      switch (response.statusCode) {
        case 200:
          if (response.data == '') {
            return null;
          } else {
            Map<String, dynamic> rawData = response.data;
            Place place = Place.walkInfo(rawData['placeId'], rawData['placeName'], Constants.imageServerUrl + rawData['placePhoto'], rawData['placeStreet'], rawData['houseNumber']);
            Walk walk = Walk(rawData['walkId'], rawData['startTime'], place);
            return walk;
          }
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<int, ApiError>> deleteWalk() async {
    return await handleRequest(() async {
      Response response = await dio.delete(path);

      switch (response.statusCode) {
        case 200:
          return response.statusCode!;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<int, ApiError>> addWalk(int placeId) async {
    return await handleRequest(() async {
      Response response = await dio.post(
          path,
          data: {
            "placeId": placeId
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

}