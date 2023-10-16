import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/services/place_service.dart';

import '../models/place.dart';

class FavouritePlacesProvider extends ChangeNotifier {
  List<Place>? _favouritePlaces;

  Future<void> fetchFavouritePlaces() async {
    _favouritePlaces = await PlaceService().getFavouritePlaces();
    notifyListeners();
  }

  List<Place>? get favouritePlaces => _favouritePlaces;

  void toggleFavouritePlace(Place place) {
    if (_favouritePlaces == null) {
      _favouritePlaces = [place];
    } else {
      final existingPlace = _favouritePlaces!.firstWhereOrNull((item) => item.id == place.id);
      if (existingPlace != null) {
        _favouritePlaces!.remove(existingPlace);
      } else {
        _favouritePlaces!.add(place);
      }
    }

    notifyListeners();
  }
}