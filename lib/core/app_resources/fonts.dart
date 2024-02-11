// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'colors.dart';

abstract class Fonts {
  static TextTheme semiLarge = TextTheme(
      bodyLarge: TextStyle(
          fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black));
  static TextTheme xsmall = TextTheme(
      bodySmall: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: ColorsManager.xsmallFontColor));
  static TextTheme medium = TextTheme(
      bodyMedium: TextStyle(
          fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.black));
  static TextTheme large = TextTheme(
      displayLarge: TextStyle(
          fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.black));
}
