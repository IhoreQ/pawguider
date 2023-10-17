import 'package:flutter/cupertino.dart';
import 'package:front_flutter/models/place_area.dart';
import 'package:front_flutter/services/place_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlacesAreasProvider extends ChangeNotifier {
  List<PlaceArea>? _areas;
  final PlaceService placeService = PlaceService();

  List<PlaceArea>? get areas => _areas;

  Future<void> fetchPlacesAreasByCityId(int cityId) async {
    _areas = await placeService.getPlacesAreasByCityId(cityId);
    notifyListeners();
  }
}