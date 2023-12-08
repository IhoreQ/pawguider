import 'package:flutter/material.dart';
import 'package:front_flutter/exceptions/api_error.dart';
import 'package:front_flutter/exceptions/result.dart';
import 'package:front_flutter/services/place_service.dart';
import 'package:front_flutter/utilities/dialog_utils.dart';

import '../models/place/place.dart';

class PlacesProvider extends ChangeNotifier {
  List<Place>? _places;
  final PlaceService _placeService = PlaceService();

  Future<void> fetchPlacesByCityId(BuildContext context, int cityId) async {
    final result = await _placeService.getPlacesByCityId(cityId);
    final value = switch (result) {
      Success(value: final places) => places,
      Failure(error: final error) => error
    };

    if (value is List<Place>) {
      _places = value;
    } else {
      _places = [];
      final error = value as ApiError;
      if (context.mounted) {
        showErrorDialog(context: context, message: error.message);
      }
    }
    notifyListeners();
  }

  List<Place>? get places => _places;
}