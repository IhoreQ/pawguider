import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:front_flutter/exceptions/api_error.dart';
import 'package:front_flutter/exceptions/result.dart';
import 'package:front_flutter/services/place_service.dart';
import 'package:front_flutter/utilities/dialog_utils.dart';

import '../models/place.dart';
import '../strings.dart';

class FavouritePlacesProvider extends ChangeNotifier {
  List<Place>? _favouritePlaces;

  Future fetchFavouritePlaces(BuildContext context) async {
    final result = await PlaceService().getFavouritePlaces();

    final value = switch (result) {
      Success(value: final places) => places,
      Failure(error: final error) => error
    };

    if (value is List<Place>) {
      _favouritePlaces = value;
    } else {
      _favouritePlaces = [];
      final error = value as ApiError;

      if (context.mounted  && error.message != ErrorStrings.checkInternetConnection) {
        showErrorDialog(context: context, message: error.message);
      }
    }

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