import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class Fonts {
  static TextStyle semiLarge = GoogleFonts.poppins(
      fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle xsmall = GoogleFonts.poppins(
      fontSize: 12.sp,
      fontWeight: FontWeight.bold,
      color: ColorsManager.xsmallFontColor);
  static TextStyle medium = GoogleFonts.poppins(
      fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.black);
  static TextStyle large = GoogleFonts.poppins(
      fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.black);
}
