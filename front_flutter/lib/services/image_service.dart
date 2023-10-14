import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';

import '../dio/dio_config.dart';

class ImageService {
  final Dio _dio = DioConfig.createDio();

  Future<String> uploadImage(File image) async {

    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: MediaType('image', 'png')
        )
      });

      Response response = await _dio.post('/image', data: formData);
      return response.data;
    } on DioException {
      return '';
    }
  }
}