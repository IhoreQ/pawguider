import 'package:flutter/material.dart';
import 'package:front_flutter/models/user.dart';
import 'package:front_flutter/services/user_service.dart';
import 'package:front_flutter/utilities/constants.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;


  Future<void> fetchCurrentUser() async {
    dynamic res = await UserService().getCurrentUser();
    _user = User(res['idUser'], res['firstName'], res['lastName'], Constants.imageServerUrl + res['photoName']);
    notifyListeners();
  }

}