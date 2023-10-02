import 'package:flutter/material.dart';

import '../../styles.dart';

class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function()? onPressed;

  const ErrorDialog({super.key, required this.title, required this.content, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      title: Text(title),
      content: SingleChildScrollView(
        child: Text(content),
      ),
      actions: [
        TextButton(
          style: AppButtonStyle.lightSplashColor,
          onPressed: onPressed ?? () {
            Navigator.of(context).pop();
          },
          child: const Text('OK', style: TextStyle(color: Colors.black),),
        ),
      ],
    );;
  }
}
