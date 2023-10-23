import 'package:flutter/material.dart';
import 'package:front_flutter/services/walk_service.dart';

import '../models/walk.dart';

class ActiveWalkProvider extends ChangeNotifier {
  Walk? walk;
  final WalkService walkService = WalkService();

  Future<void> fetchActiveWalk() async {
    walk = await walkService.getActiveWalk();
    notifyListeners();
  }

  void deleteWalk() {
    walk = null;
    notifyListeners();
  }
}