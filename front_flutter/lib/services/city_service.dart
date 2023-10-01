import 'package:dio/dio.dart';

import '../dio/dio_config.dart';

class CityService {
  final Dio _dio = DioConfig.createDio();

  Future<List<String>> getAllCities() async {
    try {
      Response response = await _dio.get('/city/all');
      List<dynamic> data = response.data;
      List<String> cities = data.map((item) => item['name'].toString()).toList();
      return cities;
    } on DioException catch (e) {
      rethrow;
    }
  }
}