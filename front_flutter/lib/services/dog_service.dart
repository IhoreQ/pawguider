import 'package:dio/dio.dart';
import 'package:front_flutter/models/dog/dog.dart';

import '../dio/dio_config.dart';
import '../utilities/constants.dart';

class DogService {
  final Dio _dio = DioConfig.createDio();

  Future<List<Dog>> getCurrentUserDogs() async {
    try {
      Response response = await _dio.get('/dog/owned');
      List<Map<String, dynamic>> rawData = List<Map<String, dynamic>>.from(response.data);

      List<Dog> dogs = rawData.map((dogData) => Dog.basic(
        dogData['id'],
        dogData['name'],
        dogData["breed"],
        dogData["gender"],
        dogData["age"],
        Constants.imageServerUrl + dogData["photoName"],
      )).toList();

      return dogs;
    } on DioException {
      rethrow;
    }
  }
}