import 'package:flutter/material.dart';
import 'package:team_player/pages/home.dart';
import 'package:team_player/pages/PlaylistPage.dart';
import 'package:team_player/pages/ProfilePage.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primarySwatch: Colors.amber,
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => Home() ,
    '/page1': (context) => PlaylistPage() ,
    '/page2': (context) => ProfilePage() ,
  },
));
