import 'package:dio/dio.dart';
import 'package:front_flutter/models/dog/behavior.dart';
import 'package:front_flutter/models/dog/dog.dart';
import 'package:front_flutter/services/basic_service.dart';
import 'package:front_flutter/services/dto/dog/dog_addition_request.dart';
import 'package:front_flutter/services/dto/dog/dog_update_request.dart';
import 'package:front_flutter/strings.dart';

import '../exceptions/api_error.dart';
import '../exceptions/result.dart';
import '../models/dog/breed.dart';
import '../utilities/constants.dart';

class DogService extends BasicService {
  final String path = '/dog';

  Future<Result<List<Dog>, ApiError>> getCurrentUserDogs() async {
    return await handleRequest(() async {
      Response response = await dio.get('$path/owned');

      switch (response.statusCode) {
        case 200:
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
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<Dog, ApiError>> getDog(int dogId) async {
    return await handleRequest(() async {
      Response response = await dio.get('$path/$dogId');

      switch (response.statusCode) {
        case 200:
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
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<List<Breed>, ApiError>> getBreeds() async {
    return await handleRequest(() async {
      Response response = await dio.get('$path/breeds');

      switch (response.statusCode) {
        case 200:
          List<dynamic> data = response.data;
          List<Breed> breeds = data.map((item) => Breed(item['id'], item['name'])).toList();
          return breeds;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<List<Behavior>, ApiError>> getBehaviors() async {
    return await handleRequest(() async {
      Response response = await dio.get('$path/behaviors');

      switch (response.statusCode) {
        case 200:
          List<dynamic> data = response.data;
          List<Behavior> behaviors = data.map((item) => Behavior(item['idBehavior'], item['name'])).toList();
          return behaviors;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<int, ApiError>> addDog(DogAdditionRequest request) async {
    return await handleRequest(() async {
      Response response = await dio.post(path, data: request.toJson());

      switch (response.statusCode) {
        case 201:
          return response.statusCode!;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<int, ApiError>> deleteDog(int dogId) async {
    return await handleRequest(() async {
      Response response = await dio.delete(
          path,
          data: {
            'dogId': dogId,
          }
      );

      switch (response.statusCode) {
        case 200:
          return response.statusCode!;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<int, ApiError>> addLike(int dogId) async {
    return await handleRequest(() async {
      Response response = await dio.post('$path/$dogId/like');

      switch (response.statusCode) {
        case 200:
          return response.statusCode!;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<int, ApiError>> deleteLike(int dogId) async {
    return await handleRequest(() async {
      Response response = await dio.delete('$path/$dogId/like');

      switch (response.statusCode) {
        case 200:
          return response.statusCode!;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }
  
  Future<Result<int, ApiError>> toggleSelected(int dogId) async {
    return await handleRequest(() async {
      Response response = await dio.patch('$path/$dogId/select');

      switch (response.statusCode) {
        case 200:
          return response.statusCode!;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<int, ApiError>> updateDog(DogUpdateRequest request) async {
    return await handleRequest(() async {
      Response response = await dio.put(path, data: request.toJson());

      switch (response.statusCode) {
        case 200:
          return response.statusCode!;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }
}