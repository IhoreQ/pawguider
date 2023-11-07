import 'package:flutter/material.dart';
import 'package:front_flutter/exceptions/api_error.dart';
import 'package:front_flutter/exceptions/result.dart';
import 'package:front_flutter/services/walk_service.dart';
import 'package:front_flutter/utilities/dialog_utils.dart';

import '../models/walk.dart';

class ActiveWalkProvider extends ChangeNotifier {
  Walk? walk;
  final WalkService walkService = WalkService();

  Future fetchActiveWalk(BuildContext context) async {
    final result = await walkService.getActiveWalk();
    final value = switch (result) {
      Success(value: final walk) => walk,
      Failure(error: final error) => error
    };

    if (value is Walk?) {
      walk = value;
    } else {
      final error = value as ApiError;
      if (context.mounted) {
        showErrorDialog(context: context, message: error.message);
      }
    }
    notifyListeners();
  }

  void deleteWalk() {
    walk = null;
    notifyListeners();
  }
}