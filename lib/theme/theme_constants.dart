import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart';


const COLOR_DARK_PRIMARY = Colors.grey;
const COLOR_DARK_ONPRIMARY = Colors.lightBlueAccent;
const COLOR_DARK_ONSECONDARY = Colors.deepOrange;
const COLOR_DARK_BACKGROUND = Colors.black12;
const COLOR_DARK_APPBAR = Colors.black12;
const COLOR_DARK_BUTTON = Colors.black54;
const COLOR_DARK_HEDDING = Colors.blue;

// Define your seed colors.
// const Color primarySeedColor = Color(0xFF6750A4);
// const Color secondarySeedColor = Color(0xFF3871BB);
// const Color tertiarySeedColor = Color(0xFF6CA450);

//---------------------------------------------------
// Theme Light
//---------------------------------------------------
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue[900],
  textTheme: const TextTheme(
    displayLarge: TextStyle(
    fontSize: 40,
    color: Colors.white,
    ),
  ),
);

//---------------------------------------------------
// Theme Dark
//---------------------------------------------------
@override
ThemeData darkTheme = ThemeData(
  useMaterial3: false,
  colorScheme: const ColorScheme.dark(
    primary: COLOR_DARK_PRIMARY,
    onPrimary: COLOR_DARK_ONPRIMARY,
    brightness: Brightness.dark,
    background: COLOR_DARK_BACKGROUND,
    onSecondary: COLOR_DARK_ONSECONDARY,

  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: COLOR_DARK_APPBAR,
    iconTheme: IconThemeData(
      color: COLOR_DARK_HEDDING,
    ),
    titleTextStyle: TextStyle(
      color: COLOR_DARK_ONPRIMARY,
      fontSize: 30,
    ),
  ),

  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'aBeeZee',
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontFamily: 'aBeeZee',
      fontSize: 30,
    ),
    displayMedium: TextStyle(
        fontFamily: 'aBeeZee',
        fontSize: 20
    ),
    displaySmall: TextStyle(
        fontFamily: 'aBeeZee',
        fontSize: 10
    ),
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.grey[700]
  ),
);
