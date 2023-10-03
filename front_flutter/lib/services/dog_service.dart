import 'package:dio/dio.dart';
import 'package:front_flutter/models/behavior.dart';
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

  Future<Dog> getDog(int dogId) async {
    try {
      Response response = await _dio.get('/dog/$dogId');
      Map<String, dynamic> rawData = response.data;

      List<Behavior> behaviors = (rawData['behaviors'] as List<dynamic>)
        .map((behaviorData) =>
          Behavior(behaviorData['idBehavior'], behaviorData['name']))
          .toList();

      Dog dog = Dog(
        rawData['idDog'],
        rawData['name'],
        rawData['breed'],
        rawData['gender'],
        rawData['age'],
        Constants.imageServerUrl + rawData['photo'],
        rawData['size'],
        rawData['description'],
        rawData['likes'],
        behaviors,
        rawData['ownerId'],
        rawData['currentUserLiked']
      );

      return dog;
    } on DioException {
      rethrow;
    }
  }

  Future<List<String>> getBreeds() async {
    try {
      Response response = await _dio.get('/dog/breeds');
      List<dynamic> data = response.data;
      List<String> breeds = data.map((item) => item['name'].toString()).toList();
      return breeds;
    } on DioException {
      rethrow;
    }
  }
}