import 'package:flutter/material.dart';

import '../styles.dart';

class CustomVerticalDivider extends StatelessWidget {
  const CustomVerticalDivider({Key? key, required this.height}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.5,
      height: height,
      color: AppColor.primaryOrange,
    );
  }
}
