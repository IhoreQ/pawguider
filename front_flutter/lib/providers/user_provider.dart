import 'package:flutter/material.dart';
import 'package:front_flutter/models/user.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;


  void fetchUser() {
    _user = User(1, 'Tytus', 'Bomba', 'https://i.imgur.com/hLqHXi7.jpg');
  }

  void updateUser() {
    _user = User(1, 'Igor', 'Bomba', 'https://i.imgur.com/hLqHXi7.jpg');
    notifyListeners();
  }

}