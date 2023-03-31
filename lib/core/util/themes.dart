import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

enum ThemeOptions {
  light,
  dark,
  system,
}

final brightness = SchedulerBinding.instance.window.platformBrightness;
const kGreenAccent = Color(0xFF4FCDAD);
const kRedAccent = Colors.redAccent;

Map<int, Color> lightSwatch = {
  50: const Color.fromRGBO(0, 0, 0, .1),
  100: const Color.fromRGBO(0, 0, 0, .2),
  200: const Color.fromRGBO(0, 0, 0, .3),
  300: const Color.fromRGBO(0, 0, 0, .4),
  400: const Color.fromRGBO(0, 0, 0, .5),
  500: const Color.fromRGBO(0, 0, 0, .6),
  600: const Color.fromRGBO(0, 0, 0, .7),
  700: const Color.fromRGBO(0, 0, 0, .8),
  800: const Color.fromRGBO(0, 0, 0, .9),
  900: const Color.fromRGBO(0, 0, 0, 1),
};

Map<int, Color> darkSwatch = {
  50: const Color.fromRGBO(255, 255, 255, .1),
  100: const Color.fromRGBO(255, 255, 255, .2),
  200: const Color.fromRGBO(255, 255, 255, .3),
  300: const Color.fromRGBO(255, 255, 255, .4),
  400: const Color.fromRGBO(255, 255, 255, .5),
  500: const Color.fromRGBO(255, 255, 255, .6),
  600: const Color.fromRGBO(255, 255, 255, .7),
  700: const Color.fromRGBO(255, 255, 255, .8),
  800: const Color.fromRGBO(255, 255, 255, .9),
  900: const Color.fromRGBO(255, 255, 255, 1),
};

MaterialColor lightPriSwatch = MaterialColor(0xFF000000, lightSwatch);
MaterialColor darkPriSwatch = MaterialColor(0xFFFFFFFF, darkSwatch);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.black,
  primarySwatch: lightPriSwatch,
  scaffoldBackgroundColor: const Color(0xFFFAFAFA),
  appBarTheme: const AppBarTheme(
    color: const Color(0xFFFAFAFA),
    foregroundColor: Colors.black,
    elevation: 0,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: lightPriSwatch).copyWith(
    secondary: const Color(0xFFBBBBBB),
    background: const Color(0xFFDFDFDF),
    brightness: Brightness.light,
    error: kRedAccent,
  ),
  dividerColor: const Color(0xFFDFDFDF),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFBBBBBB)),
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.white,
  primarySwatch: darkPriSwatch,
  scaffoldBackgroundColor: const Color(0xFF2E2E2E),
  appBarTheme: const AppBarTheme(
    color: const Color(0xFF2E2E2E),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: darkPriSwatch).copyWith(
    secondary: const Color(0xFF545454),
    brightness: Brightness.dark,
    background: const Color(0xFF7A7A7A),
    error: kRedAccent,
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
  ),
  dividerColor: const Color(0xFF7A7A7A),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF545454)),
      borderRadius: BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF545454)),
      borderRadius: BorderRadius.circular(12),
    ),
  ),
);

final themeOptions = {
  ThemeOptions.light: lightTheme,
  ThemeOptions.dark: darkTheme,
  ThemeOptions.system: brightness == Brightness.light ? lightTheme : darkTheme,
};
