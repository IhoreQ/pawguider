import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppColor {
  static const Color primaryOrange = Color.fromRGBO(246, 146, 70, 1.0);
  static const Color backgroundOrange = Color.fromRGBO(254, 235, 220, 1.0);
  static const Color backgroundOrange2 = Color.fromRGBO(255, 223, 183, 1.0);
  static const Color orangeAccent = Color.fromRGBO(254, 245, 236, 1.0);
  static const Color darkText = Color.fromRGBO(64, 63, 69, 1.0);
  static const Color lightText = Color.fromRGBO(143, 143, 143, 1.0);
}

abstract class AppTextStyle {
  static TextStyle heading1 = const TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 30.0,
    color: AppColor.darkText
  );
  static TextStyle heading2 = const TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 20.0,
      color: AppColor.darkText
  );
  static TextStyle heading3 = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 17.0,
      color: AppColor.lightText
  );
  static TextStyle appBarTitleHeading = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20.0,
    color: AppColor.darkText,
  );
}