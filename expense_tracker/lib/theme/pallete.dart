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
      brightness: Brightness.dark,
      primary: blueColor,
      onPrimary: whiteColor,
      secondary: blueColor,
      onSecondary: whiteColor,
      error: Colors.red,
      onError: whiteColor,
      background: drawerColor,
      onBackground: whiteColor,
      surface: greyColor,
      onSurface: whiteColor,
    ),
  );

  static var lightModeAppTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: whiteColor,
    cardColor: whiteColor,
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
      primary: blueColor,
      onPrimary: blackColor,
      secondary: blueColor,
      onSecondary: blackColor,
      error: Colors.red,
      onError: whiteColor,
      background: whiteColor,
      onBackground: blackColor,
      surface: whiteColor,
      onSurface: blackColor,
    ),
  );
}
