import 'package:dio/dio.dart';
import 'package:front_flutter/exceptions/api_error.dart';
import 'package:front_flutter/exceptions/result.dart';
import 'package:front_flutter/services/basic_service.dart';

import '../strings.dart';

class GenderService extends BasicService {
  final String path = '/gender';

  Future<Result<List<String>, ApiError>> getAllGenders() async {
    return await handleRequest(() async {
      Response response = await dio.get('$path/all');

      switch (response.statusCode) {
        case 200:
          List<dynamic> data = response.data;
          List<String> genderNames = data.map((item) => item['name'].toString()).toList();
          return genderNames;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }
}