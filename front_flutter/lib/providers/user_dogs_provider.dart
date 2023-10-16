import 'package:flutter/widgets.dart';
import 'package:front_flutter/services/dog_service.dart';

import '../models/dog/dog.dart';

class UserDogsProvider extends ChangeNotifier {
  List<Dog>? _dogs;
  int _dogsSelected = 0;
  final int _walkPartnersLimit = 3;
  final DogService dogService = DogService();

  Future<void> fetchUserDogs() async {
    _dogs = await dogService.getCurrentUserDogs();
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