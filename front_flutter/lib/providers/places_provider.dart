import 'package:flutter/foundation.dart';
import 'package:front_flutter/services/place_service.dart';

import '../models/place.dart';

class PlacesProvider extends ChangeNotifier {
  List<Place>? _places;
  final PlaceService _placeService = PlaceService();

  Future<void> fetchPlacesByCityId(int cityId) async {
    _places = await _placeService.getPlacesByCityId(cityId);
    notifyListeners();
  }

  List<Place>? get places => _places;
}