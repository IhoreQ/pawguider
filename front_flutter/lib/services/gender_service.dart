import 'package:dio/dio.dart';

import '../dio/dio_config.dart';

class GenderService {
  final Dio _dio = DioConfig.createDio();

  Future<List<String>> getAllGenders() async {
    try {
      Response response = await _dio.get('/gender/all');
      List<dynamic> data = response.data;
      List<String> genderNames = data.map((item) => item['name'].toString()).toList();
      return genderNames;
    } on DioException {
      rethrow;
    }
  }

  Future<List<String>> getBasicGenders() async {
    try {
      Response response = await _dio.get('/gender/basic');
      List<dynamic> data = response.data;
      List<String> genderNames = data.map((item) => item['name'].toString()).toList();
      return genderNames;
    } on DioException {
      rethrow;
    }
  }

}