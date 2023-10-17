import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flex_seed_scheme/flex_seed_scheme.dart';

const FONT_MAIN =   GoogleFonts.aBeeZee;

const COLOR_DARK_PRIMARY = Colors.deepOrange;
const COLOR_DARK_BACKGROUND = Colors.black12;
const COLOR_DARK_APPBAR = Colors.black26;
const COLOR_DARK_BUTTON = Colors.black54;

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
ThemeData darkTheme = ThemeData(
  //useMaterial3: false,
  colorScheme: const ColorScheme.dark(
    primary: COLOR_DARK_PRIMARY,
    onPrimary: Colors.blue,
    brightness: Brightness.dark,
    background: COLOR_DARK_BACKGROUND,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: COLOR_DARK_APPBAR,
  ),
  textTheme: TextTheme(
    displayLarge: FONT_MAIN(
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: FONT_MAIN(
      fontSize: 30,
    ),
    displayMedium: FONT_MAIN(fontSize: 20),
    displaySmall: FONT_MAIN(fontSize: 10),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.grey[700]
  ),
);
