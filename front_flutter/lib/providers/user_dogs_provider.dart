import 'package:flutter/widgets.dart';
import 'package:front_flutter/exceptions/api_error.dart';
import 'package:front_flutter/exceptions/result.dart';
import 'package:front_flutter/services/dog_service.dart';
import 'package:front_flutter/utilities/dialog_utils.dart';

import '../models/dog/dog.dart';
import '../strings.dart';

class UserDogsProvider extends ChangeNotifier {
  List<Dog>? _dogs;
  int _dogsSelected = 0;
  final int _walkPartnersLimit = 3;
  final DogService dogService = DogService();

  Future fetchUserDogs(BuildContext context) async {
    final result = await dogService.getCurrentUserDogs();
    final value = switch (result) {
      Success(value: final dogs) => dogs,
      Failure(error: final error) => error
    };

    if (value is List<Dog>) {
      _dogs = value;
    } else {
      _dogs = [];
      final error = value as ApiError;
      if (context.mounted  && error.message != ErrorStrings.checkInternetConnection) {
        showErrorDialog(context: context, message: error.message);
      }
    }

    _dogsSelected = _dogs!.where((dog) => dog.selected!).toList().length;
    notifyListeners();
  }

  bool isLimitNotExceeded() {
    return _dogsSelected < _walkPartnersLimit;
  }

  void incrementDogsCount() {
    _dogsSelected++;
    notifyListeners();
  }

  void decrementDogsCount() {
    _dogsSelected--;
    notifyListeners();
  }

  List<Dog>? get dogs => _dogs;

  int get dogsSelected => _dogsSelected;

  int get walkPartnersLimit => _walkPartnersLimit;
}