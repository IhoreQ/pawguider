import 'package:dio/dio.dart';
import 'package:front_flutter/exceptions/api_error.dart';
import 'package:front_flutter/models/place_area.dart';
import 'package:front_flutter/services/basic_service.dart';
import 'package:front_flutter/strings.dart';
import 'package:front_flutter/utilities/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../exceptions/result.dart';
import '../models/dog/dog.dart';
import '../models/place.dart';

class PlaceService extends BasicService {
  final String path = '/place';

  Future<Result<List<Place>, ApiError>> getPlacesByCityId(int cityId) async {
    return await handleRequest(() async {
      Response response = await dio.get('$path/city/$cityId');

      switch (response.statusCode) {
        case 200:
          List<Map<String, dynamic>> rawData = List<Map<String, dynamic>>.from(response.data);
          List<Place> places = rawData.map((placeData) => Place.basicInfo(
              placeData['id'],
              placeData['name'],
              placeData['street'],
              placeData['houseNumber'],
              placeData['dogsCount'],
              placeData['averageScore'],
              Constants.imageServerUrl + placeData['photoName']
          )).toList();

          return places;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<Place, ApiError>> getPlaceById(int placeId) async {
    return await handleRequest(() async {
      Response response = await dio.get('$path/$placeId');

      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> placeData = response.data;
          Place place = Place(
              placeId,
              placeData['name'],
              placeData['street'],
              placeData['houseNumber'],
              placeData['zipCode'],
              placeData['city'],
              placeData['description'],
              placeData['averageScore'],
              Constants.imageServerUrl + placeData['photoName'],
              placeData['currentUserLiked'],
              placeData['currentUserRated'],
              placeData['currentUserScore']
          );

          return place;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<int, ApiError>> addRating(int placeId, double rating) async {
    return await handleRequest(() async {
      Response response = await dio.post(
          '$path/rate',
          data: {
            "placeId": placeId,
            "rating": rating
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

  Future<Result<int, ApiError>> updateRating(int placeId, double rating) async {
    return await handleRequest(() async {
      Response response = await dio.patch(
          '$path/rate',
          data: {
            "placeId": placeId,
            "rating": rating
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

  Future<Result<int, ApiError>> addLike(int placeId) async {
    return await handleRequest(() async {
      Response response = await dio.post('$path/$placeId/like');

      switch (response.statusCode) {
        case 200:
          return response.statusCode!;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<int, ApiError>> deleteLike(int placeId) async {
    return await handleRequest(() async {
      Response response = await dio.delete('$path/$placeId/like');

      switch (response.statusCode) {
        case 200:
          return response.statusCode!;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<List<Place>, ApiError>> getFavouritePlaces() async {
    return await handleRequest(() async {
      Response response = await dio.get('$path/favourites');

      switch (response.statusCode) {
        case 200:
          List<Map<String, dynamic>> rawData = List<Map<String, dynamic>>.from(response.data);
          List<Place> places = rawData.map((placeData) => Place.favouriteInfo(
              placeData['id'],
              placeData['name'],
              placeData['street'],
              placeData['city'],
              Constants.imageServerUrl + placeData['photoName']
          )).toList();

          return places;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<List<PlaceArea>, ApiError>> getPlacesAreasByCityId(int cityId) async {
    return await handleRequest(() async {
      Response response = await dio.get('$path/areas/city/$cityId');

      switch (response.statusCode) {
        case 200:
          List<Map<String, dynamic>> rawData = List<Map<String, dynamic>>.from(response.data);
          List<PlaceArea> areas = rawData.map((areaData) => PlaceArea.fromJson(areaData)).toList();
          return areas;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<bool, ApiError>> isUserInPlaceArea(int placeId, LatLng position) async {
    return await handleRequest(() async {
      Response response = await dio.get(
          '$path/$placeId/area',
          data: {
            "latitude": position.latitude,
            "longitude": position.longitude
          }
      );

      switch (response.statusCode) {
        case 200:
          return response.data;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<int?, ApiError>> findUserPlaceArea(LatLng position) async {
    return await handleRequest(() async {
      Response response = await dio.get(
          '$path/area',
          data: {
            "latitude": position.latitude,
            "longitude": position.longitude
          }
      );

      switch (response.statusCode) {
        case 200:
          return response.data == '' ? null : response.data;
        default:
          throw Exception(ErrorStrings.defaultError);
      }
    });
  }

  Future<Result<List<Dog>, ApiError>> getAllDogsFromPlace(int placeId) async {
    return await handleRequest(() async {
      Response response = await dio.get('$path/$placeId/dogs');

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

}