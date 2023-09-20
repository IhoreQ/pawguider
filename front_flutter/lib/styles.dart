import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppColor {
  static const Color primaryOrange = Color.fromRGBO(246, 146, 70, 1.0);
  static const Color backgroundOrange = Color.fromRGBO(254, 235, 220, 1.0);
  static const Color backgroundOrange2 = Color.fromRGBO(255, 223, 183, 1.0);
  static const Color orangeAccent = Color.fromRGBO(254, 245, 236, 1.0);
  static const Color darkText = Color.fromRGBO(64, 63, 69, 1.0);
  static const Color lightText = Color.fromRGBO(143, 143, 143, 1.0);
  static const Color lightGray = Color.fromRGBO(220, 220, 220, 1.0);
}

abstract class AppTextStyle {
  static TextStyle whiteHeading = GoogleFonts.montserrat(
    fontWeight: FontWeight.w700,
    fontSize: 25.0,
    color: Colors.white
  );

  static TextStyle mediumDark = GoogleFonts.montserrat(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      color: AppColor.darkText
  );

  static TextStyle semiBoldOrange = GoogleFonts.montserrat(
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
      color: AppColor.primaryOrange
  );

  static TextStyle regularOrange = GoogleFonts.montserrat(
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    color: AppColor.primaryOrange
  );

  static TextStyle mediumOrange = GoogleFonts.montserrat(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
      color: AppColor.primaryOrange
  );

  static TextStyle mediumWhite = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: Colors.white
  );

  static TextStyle regularLight = GoogleFonts.montserrat(
      fontWeight: FontWeight.w400,
      fontSize: 16.0,
      color: AppColor.lightText
  );

  static TextStyle mediumLight = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
    color: AppColor.lightText
  );

  static TextStyle semiBoldLight = GoogleFonts.montserrat(
      fontWeight: FontWeight.w600,
      fontSize: 16.0,
      color: AppColor.lightText
  );

  static TextStyle heading1 = GoogleFonts.montserrat(
    fontWeight: FontWeight.w700,
    fontSize: 30.0,
    color: AppColor.darkText
  );
  static TextStyle heading2 = GoogleFonts.montserrat(
      fontWeight: FontWeight.w600,
      fontSize: 17.0,
      color: AppColor.darkText
  );
  static TextStyle heading3 = GoogleFonts.montserrat(
      fontWeight: FontWeight.w600,
      fontSize: 14.0,
      color: AppColor.lightText
  );
  static TextStyle appBarTitleHeading = GoogleFonts.montserrat(
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
    color: Colors.white,
  );
  static TextStyle errorText = GoogleFonts.montserrat(
    fontWeight: FontWeight.w500,
    fontSize: 12.0,
    color: Colors.red
  );
}

abstract class AppShadow {
  static BoxShadow infoBoxShadow = BoxShadow(
    blurRadius: 15.0,
    spreadRadius: 0.0,
    offset: const Offset(0, 5),
    color: Colors.black.withOpacity(0.1)
  );

  static BoxShadow photoShadow = BoxShadow(
      blurRadius: 8.0,
      spreadRadius: 2.0,
      offset: const Offset(0, 5),
      color: Colors.black.withOpacity(0.15)
  );
}