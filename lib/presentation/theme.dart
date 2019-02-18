import 'package:flutter/material.dart';

final appTheme = ThemeData(primaryColor: AppThemeColors.primaryColor);

final apodTitleTextStyle = TextStyle(color: AppThemeColors.textHighlight, fontFamily: "Nasa");

class AppThemeColors {
  AppThemeColors._internal();

  static final Color primaryColor = Colors.black;

  static final Color background = Color.fromRGBO(16, 16, 16, 1.0);
  static final Color cardBackground = Color.fromRGBO(32, 32, 32, 1.0);

  static final Color text = Colors.white54;
  static final Color textCard = Colors.white70;
  static final Color textHighlight = Colors.white;
}