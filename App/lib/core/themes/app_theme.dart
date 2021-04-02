import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._();

  static const Color info_light = Color(0xFF545355);
  static const Color primary_light = Color(0xFF89C99E);
  static const Color text2_light = Color(0xFFC3BFBF);
  static const Color text1_light = Color(0xFF8E8E93);
  static const Color subtitle_light = Colors.white;
  static const Color error_light = Color(0xFFCE3232);
  static const Color success_color = Color(0xFF47B560);

  static final lightTheme = ThemeData(
    errorColor: error_light,
    bottomAppBarColor: info_light,
    highlightColor: info_light,
    textTheme: GoogleFonts.heeboTextTheme(
      TextTheme(
        bodyText1: TextStyle(color: text1_light),
        bodyText2: TextStyle(color: text2_light),
        subtitle1: TextStyle(color: subtitle_light),
      ),
    ),
    primaryColor: primary_light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

extension ThemeDataColors on ThemeData {
  Color get success => AppTheme.success_color;
}
