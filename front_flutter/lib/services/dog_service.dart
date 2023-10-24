import 'package:dio/dio.dart';
import 'package:front_flutter/models/dog/behavior.dart';
import 'package:front_flutter/models/dog/dog.dart';
import 'package:front_flutter/services/dto/dog/dog_addition_request.dart';
import 'package:front_flutter/services/dto/dog/dog_update_request.dart';

import '../dio/dio_config.dart';
import '../models/dog/breed.dart';
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
        dogData["selected"]
      )).toList();

      return dogs;
    } on DioException {
      rethrow;
    }
  }

  Future<dynamic> getDog(int dogId) async {
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
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return 404;
      } else {
        return null;
      }
    }
  }

  Future<List<Breed>> getBreeds() async {
    try {
      Response response = await _dio.get('/dog/breeds');
      List<dynamic> data = response.data;
      List<Breed> breeds = data.map((item) => Breed(item['id'], item['name'])).toList();
      return breeds;
    } on DioException {
      rethrow;
    }
  }

  Future<List<Behavior>> getBehaviors() async {
    try {
      Response response = await _dio.get('/dog/behaviors');
      List<dynamic> data = response.data;
      List<Behavior> behaviors = data.map((item) => Behavior(item['idBehavior'], item['name'])).toList();
      return behaviors;
    } on DioException {
      rethrow;
    }
  }

  Future<bool> addDog(DogAdditionRequest request) async {
    try {
      Response response = await _dio.post('/dog', data: request.toJson());
      return true;
    } on DioException {
      return false;
    }
  }

  Future<bool> deleteDog(int dogId) async {
    try {
      Response response = await _dio.delete(
        '/dog',
        data: {
        'dogId': dogId,
        }
      );
      return true;
    } on DioException {
      return false;
    }
  }

  Future<bool> addLike(int dogId) async {
    try {
      Response response = await _dio.post('/dog/like/$dogId');
      return true;
    } on DioException {
      return false;
    }
  }

  Future<bool> deleteLike(int dogId) async {
    try {
      Response response = await _dio.delete('/dog/like/$dogId');
      return true;
    } on DioException {
      return false;
    }
  }
  
  Future<bool> toggleSelected(int dogId) async {
    try {
      Response response = await _dio.patch('/dog/select/$dogId');
      return true;
    } on DioException {
      return false;
    }
  }

  Future<bool> updateDog(DogUpdateRequest request) async {
    try {
      Response response = await _dio.put('/dog', data: request.toJson());
      return true;
    } on DioException {
      return false;
    }
  }
}