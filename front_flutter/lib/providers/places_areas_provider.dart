import 'package:flutter/cupertino.dart';
import 'package:front_flutter/exceptions/api_error.dart';
import 'package:front_flutter/exceptions/result.dart';
import 'package:front_flutter/models/place/place_area.dart';
import 'package:front_flutter/services/place_service.dart';
import 'package:front_flutter/utilities/dialog_utils.dart';

class PlacesAreasProvider extends ChangeNotifier {
  List<PlaceArea>? _areas;
  final PlaceService placeService = PlaceService();

  List<PlaceArea>? get areas => _areas;

  Future fetchPlacesAreasByCityId(BuildContext context, int cityId) async {
    final result = await placeService.getPlacesAreasByCityId(cityId);

    final value = switch (result) {
      Success(value: final places) => places,
      Failure(error: final error) => error
    };

    if (value is List<PlaceArea>) {
      _areas = value;
    } else {
      _areas = [];
      final error = value as ApiError;
      if (context.mounted) {
        showErrorDialog(context: context, message: error.message);
      }
    }

    notifyListeners();
  }
}