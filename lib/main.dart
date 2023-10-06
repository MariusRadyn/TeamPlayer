import 'package:flutter/material.dart';
import 'package:team_player/pages/home.dart';
import 'package:team_player/pages/page2.dart';
import 'package:team_player/pages/page3.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primarySwatch: Colors.amber,
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => Home() ,
    '/page1': (context) => Page2() ,
    '/page2': (context) => Page3() ,
  },
));
