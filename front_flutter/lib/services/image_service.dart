import 'package:dio/dio.dart';

import '../dio/dio_config.dart';

class ImageService {
  final Dio _dio = DioConfig.createDio();

  Future<Map<String, dynamic>> uploadImage() async {
    try {
      Response response = await _dio.post('/image');
      return response.data;
    } on DioException catch (e) {
      rethrow;
    }
  }
}