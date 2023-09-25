import 'package:flutter/material.dart';

import '../styles.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.label, required this.onPressed});

  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
        style: FilledButton.styleFrom(
          elevation: 10,
          shadowColor: Colors.black.withOpacity(0.3),
          backgroundColor: AppColor.primaryOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          minimumSize: const Size.fromHeight(50.0),
        ),
        onPressed: () => onPressed(),
        child: Text(
          label,
          style: AppTextStyle.semiBoldWhite,
        )
    );
  }
}
