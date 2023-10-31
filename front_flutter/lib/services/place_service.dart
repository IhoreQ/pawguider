import 'package:dio/dio.dart';
import 'package:front_flutter/models/place_area.dart';
import 'package:front_flutter/utilities/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../dio/dio_config.dart';
import '../models/dog/dog.dart';
import '../models/place.dart';

class PlaceService {
  final Dio _dio = DioConfig.createDio();

  Future<List<Place>> getPlacesByCityId(int cityId) async {
    try {
      Response response = await _dio.get('/place/city/$cityId');
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
    } on DioException {
      rethrow;
    }
  }

  Future<Place> getPlaceById(int placeId) async {
    try {
      Response response = await _dio.get('/place/$placeId');
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
    } on DioException {
      rethrow;
    }
  }

  Future<bool> addRating(int placeId, double rating) async {
    try {
      Response response = await _dio.post(
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
      Response response = await _dio.patch(
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
      Response response = await _dio.post('/place/$placeId/like');
      return true;
    } on DioException {
      return false;
    }
  }

  Future<bool> deleteLike(int placeId) async {
    try {
      Response response = await _dio.delete('/place/$placeId/like');
      return true;
    } on DioException {
      return false;
    }
  }

  Future<List<Place>> getFavouritePlaces() async {
    try {
      Response response = await _dio.get('/place/favourites');
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
      print('favourite places error');
      return [];
    }
  }

  Future<List<PlaceArea>> getPlacesAreasByCityId(int cityId) async {
    try {
      Response response = await _dio.get('/place/areas/city/$cityId');
      List<Map<String, dynamic>> rawData = List<Map<String, dynamic>>.from(response.data);
      List<PlaceArea> areas = rawData.map((areaData) => PlaceArea.fromJson(areaData)).toList();
      return areas;
    } on DioException {
      return [];
    }
  }

  Future<bool> isUserInPlaceArea(int placeId, LatLng position) async {
    try {
      Response response = await _dio.get(
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
      Response response = await _dio.get(
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
      Response response = await _dio.get(
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