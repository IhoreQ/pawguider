import 'package:flutter/cupertino.dart';

import '../styles.dart';

class SizedErrorText extends StatelessWidget {
  const SizedErrorText({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.0,
      child: Center(child: Text(message, style: AppTextStyle.errorText.copyWith(fontSize: 14.0), textAlign: TextAlign.center,)),
    );
  }
}
