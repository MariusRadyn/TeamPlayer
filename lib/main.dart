import 'package:flutter/material.dart';
import 'package:team_player/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_player/pages/PlaylistPage.dart';
import 'package:team_player/pages/ProfilePage.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.black26,brightness: Brightness.light,),
    textTheme: TextTheme(
      displayLarge: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold,),
      titleLarge: GoogleFonts.rubikPixels(fontSize: 30,fontStyle: FontStyle.italic,),
      bodyMedium: GoogleFonts.merriweather(),
      displaySmall: GoogleFonts.pacifico(),
    ),
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => Home() ,
    '/page1': (context) => PlaylistPage() ,
    '/page2': (context) => ProfilePage() ,
  },
));
