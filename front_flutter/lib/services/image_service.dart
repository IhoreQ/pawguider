import 'dart:io';
import 'package:front_flutter/services/basic_service.dart';
import 'package:front_flutter/strings.dart';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';

import '../exceptions/api_error.dart';
import '../exceptions/result.dart';


class ImageService extends BasicService {
  final String path = '/image';

  Future<Result<String, ApiError>> uploadImage(File image) async {
    return await handleRequest(() async {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
            contentType: MediaType('image', 'png')
        )
      });

      Response response = await dio.post(path, data: formData);

      switch (response.statusCode) {
        case 200:
          final String photoName = response.data;
          return photoName;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<int, ApiError>> deleteImage(String imageName) async {
    return await handleRequest(() async {
      Response response = await dio.delete('$path/$imageName');

      switch (response.statusCode) {
        case 200:
          return response.statusCode!;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }
}