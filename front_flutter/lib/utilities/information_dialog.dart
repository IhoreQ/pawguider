import 'package:flutter/material.dart';

import '../widgets/dialogs/error_dialog.dart';

abstract class InformationDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String content,
    Function()? onPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ErrorDialog(
          title: title,
          content: content,
          onPressed: onPressed,
        );
      },
    );
  }
}
