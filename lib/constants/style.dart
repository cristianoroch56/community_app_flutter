// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:flutter/material.dart';

// Color fontColor = const Color(0xff121112);
Color secondaryColor1 = const Color(0xffD0658E);
Color secondaryColor2 = const Color(0xffFB796B);
Color secondaryColor3 = const Color(0xfff374bb);
Color headingColor = const Color(0xff000000);
Color COLOR_PRIMARY = const Color(0xffFFA53D);
Color COLOR_PRIMARYLIGHT = const Color(0xff121112).withOpacity(0.5);
Color COLOR_WHITE = const Color(0xffFFFFFF);
Color COLOR_PRIMARYDARK = const Color(0xff121112);
Color COLOR_LIGHTGRAY = const Color(0xfff6f5f6);
Color COLOR_BOXSHADOW = const Color(0xffc1c4be);
Color COLOR_ARROW = const Color(0xff121112);

const fontSemiBold = 'Poppins-SemiBold';
const fontMedium = 'Poppins-Medium';
const fontRegular = 'Poppins-Regular';

const String card = 'assets/lottie/no_data.json';

enum AppTheme {
  CustomTheme,
  LightTheme,
  DarkTheme,
}

final appThemeData = {
  AppTheme.CustomTheme: ThemeData.light().copyWith(
    primaryColor: COLOR_PRIMARY,
    primaryColorLight: COLOR_PRIMARYLIGHT,
    primaryColorDark: COLOR_PRIMARYDARK,
    scaffoldBackgroundColor: COLOR_WHITE,
    appBarTheme: AppBarTheme(
      backgroundColor: COLOR_WHITE,
      elevation: 0,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryTextTheme:
        TextTheme(titleSmall: TextStyle(color: COLOR_PRIMARYDARK)),
  ),
  AppTheme.LightTheme: ThemeData(
    brightness: Brightness.light,
  ),
  AppTheme.DarkTheme: ThemeData(
    brightness: Brightness.dark,
  )
};
