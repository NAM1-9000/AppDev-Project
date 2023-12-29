import 'package:flutter/material.dart';

class Pallete {
  static const blackColor = Color.fromRGBO(1, 1, 1, 1);
  static const greyColor = Color.fromRGBO(26, 39, 45, 1);
  static const drawerColor = Color.fromRGBO(18, 18, 18, 1);
  static const whiteColor = Colors.white;
  static var redColor = Colors.red.shade500;
  static var blueColor = Colors.blue.shade300;

  static var darkModeAppTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: blackColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: drawerColor,
      iconTheme: IconThemeData(
        color: whiteColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: drawerColor,
    ),
    primaryColor: redColor,
    colorScheme: ColorScheme(
      brightness: Brightness.dark, // Changed to dark
      primary: redColor,
      onPrimary: whiteColor,
      secondary: blueColor,
      onSecondary: whiteColor,
      error: Colors.red,
      onError: whiteColor,
      background: drawerColor,
      onBackground: whiteColor,
      surface: greyColor, // Changed to greyColor
      onSurface: whiteColor, // Changed to whiteColor
    ),
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: whiteColor,
    cardColor: greyColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: blackColor,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: whiteColor,
    ),
    primaryColor: redColor,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: redColor,
      onPrimary: blackColor, // Changed to blackColor
      secondary: blueColor,
      onSecondary: blackColor, // Changed to blackColor
      error: Colors.red,
      onError: whiteColor,
      background: whiteColor,
      onBackground: blackColor, // Changed to blackColor
      surface: whiteColor,
      onSurface: blackColor,
    ),
  );
}
