import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/products/constants/colors_contants.dart';

abstract class ProjectTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    outlinedButtonTheme: const OutlinedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      centerTitle: true,
    ),
    tabBarTheme: const TabBarTheme(
      indicatorColor: ColorConstants.monteCarlo,
      labelColor: ColorConstants.monteCarlo,
      unselectedLabelColor: Colors.black,
      labelPadding: EdgeInsets.all(10),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
    ),
    cardTheme: const CardTheme(
      color: Colors.transparent,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      outlineBorder: BorderSide(color: ColorConstants.gainsBoro, width: 2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: 'Poppins',
    outlinedButtonTheme: const OutlinedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 15)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      centerTitle: true,
    ),
    tabBarTheme: const TabBarTheme(
      indicatorColor: ColorConstants.monteCarlo,
      labelColor: ColorConstants.monteCarlo,
      unselectedLabelColor: Colors.black,
      labelPadding: EdgeInsets.all(10),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
    ),
    cardTheme: const CardTheme(
      color: Colors.transparent,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      outlineBorder: BorderSide(color: ColorConstants.gainsBoro, width: 2),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  );
}
