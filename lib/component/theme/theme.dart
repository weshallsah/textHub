import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  TextStyle? titleTextup;
  TextStyle? titleHubdown;
  TextStyle? titleHubup;
  static ThemeData LigthTheme = ThemeData();
  static ThemeData darkTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        
        fontSize: 20.sp,
        fontFamily: "Poppins",
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontSize: 20.sp,
        fontFamily: "Poppins",
      ),
      bodyMedium: TextStyle(
        fontFamily: "Poppins",
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
      ),
      bodySmall: TextStyle(
        color: Colors.white,
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        fontFamily: "Poppins",
      ),
      titleSmall: TextStyle(
        color: Colors.white,
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        fontFamily: GoogleFonts.poppins().toString(),
      ),
    ),
    // unselectedWidgetColor: Colors.white,
    
    canvasColor: Colors.black,
  );
}
