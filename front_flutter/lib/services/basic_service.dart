import 'package:dio/dio.dart';

import '../dio/dio_config.dart';

class BasicService {
  final Dio _dio = DioConfig.createDio();

  Dio get dio => _dio;
}