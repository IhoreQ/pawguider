import 'package:dio/dio.dart';
import 'package:front_flutter/utilities/constants.dart';

import '../dio/dio_config.dart';
import '../models/place.dart';

class PlaceService {
  final Dio _dio = DioConfig.createDio();

  Future<List<Place>> getPlacesByCityId(int cityId) async {
    try {
      Response response = await _dio.get('/place/city-$cityId');
      List<Map<String, dynamic>> rawData = List<Map<String, dynamic>>.from(response.data);
      List<Place> places = rawData.map((placeData) => Place.basicInfo(
          placeData['id'],
          placeData['name'],
          placeData['street'],
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
      Response response = await _dio.post('/place/like/$placeId');
      return true;
    } on DioException {
      return false;
    }
  }

  Future<bool> deleteLike(int placeId) async {
    try {
      Response response = await _dio.delete('/place/like/$placeId');
      return true;
    } on DioException {
      return false;
    }
  }
}