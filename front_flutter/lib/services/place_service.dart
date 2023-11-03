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

  Future<bool> addRating(int placeId, double rating) async {
    try {
      Response response = await dio.post(
        '/place/rate',
        data: {
          "placeId": placeId,
          "rating": rating
        }
      );

      return true;
    } on DioException {
      return false;
    }
  }

  Future<bool> updateRating(int placeId, double rating) async {
    try {
      Response response = await dio.patch(
          '/place/rate',
          data: {
            "placeId": placeId,
            "rating": rating
          }
      );

      return true;
    } on DioException {
      return false;
    }
  }

  Future<bool> addLike(int placeId) async {
    try {
      Response response = await dio.post('/place/$placeId/like');
      return true;
    } on DioException {
      return false;
    }
  }

  Future<bool> deleteLike(int placeId) async {
    try {
      Response response = await dio.delete('/place/$placeId/like');
      return true;
    } on DioException {
      return false;
    }
  }

  Future<List<Place>> getFavouritePlaces() async {
    try {
      Response response = await dio.get('/place/favourites');
      List<Map<String, dynamic>> rawData = List<Map<String, dynamic>>.from(response.data);
      List<Place> places = rawData.map((placeData) => Place.favouriteInfo(
          placeData['id'],
          placeData['name'],
          placeData['street'],
          placeData['city'],
          Constants.imageServerUrl + placeData['photoName']
      )).toList();

      return places;
    } on DioException {
      return [];
    }
  }

  Future<List<PlaceArea>> getPlacesAreasByCityId(int cityId) async {
    try {
      Response response = await dio.get('/place/areas/city/$cityId');
      List<Map<String, dynamic>> rawData = List<Map<String, dynamic>>.from(response.data);
      List<PlaceArea> areas = rawData.map((areaData) => PlaceArea.fromJson(areaData)).toList();
      return areas;
    } on DioException {
      return [];
    }
  }

  Future<bool> isUserInPlaceArea(int placeId, LatLng position) async {
    try {
      Response response = await dio.get(
        '/place/$placeId/area',
        data: {
          "latitude": position.latitude,
          "longitude": position.longitude
        }
      );
      return response.data;
    } on DioException {
      rethrow;
    }
  }

  Future<int?> findUserPlaceArea(LatLng position) async {
    try {
      Response response = await dio.get(
        '/place/area',
        data: {
          "latitude": position.latitude,
          "longitude": position.longitude
        }
      );
      return response.data == '' ? null : response.data;
    } on DioException {
      rethrow;
    }
  }

  Future<List<Dog>> getAllDogsFromPlace(int placeId) async {
    try {
      Response response = await dio.get(
        '/place/$placeId/dogs'
      );
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
      return [];
    }
   }

}