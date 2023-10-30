import 'package:flutter/material.dart';
import 'package:front_flutter/models/user.dart';
import 'package:front_flutter/services/auth_service.dart';
import 'package:front_flutter/services/user_service.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  final UserService userService = UserService();
  final AuthService authService = AuthService();

  User? get user => _user;


  Future<void> fetchCurrentUser(BuildContext context) async {
    _user = await userService.getCurrentUser();
    if (_user == null && context.mounted) {
      authService.logout(context);
    }
    notifyListeners();
  }

  String? get photoName => _user!.photoUrl!.split('/').last;
}