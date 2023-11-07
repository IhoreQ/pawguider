import 'package:flutter/material.dart';
import 'package:front_flutter/exceptions/api_error.dart';
import 'package:front_flutter/exceptions/result.dart';
import 'package:front_flutter/models/user.dart';
import 'package:front_flutter/services/auth_service.dart';
import 'package:front_flutter/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  final UserService userService = UserService();
  final AuthService authService = AuthService();

  User? get user => _user;


  Future fetchCurrentUser(BuildContext context) async {
    final result = await userService.getCurrentUser();
    final value = switch (result) {
      Success(value: final user) => user,
      Failure(error: final error) => error
    };

    if (value is User) {
      _user = value;
    } else {
      _user = null;

      final error = value as ApiError;
      print(error);
    }
    notifyListeners();
  }

  String? get photoName => _user!.photoUrl!.split('/').last;
}