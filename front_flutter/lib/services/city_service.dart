import 'package:dio/dio.dart';
import 'package:front_flutter/exceptions/api_error.dart';
import 'package:front_flutter/services/basic_service.dart';
import 'package:front_flutter/strings.dart';

import '../exceptions/result.dart';

class CityService extends BasicService {

  Future<Result<List<String>, ApiError>> getAllCities() async {
    return await handleRequest(() async {
      Response response = await dio.get('/city/all');

      switch (response.statusCode) {
        case 200:
          List<dynamic> data = response.data;
          List<String> cities = data.map((item) => item['name'].toString()).toList();
          return cities;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }
}