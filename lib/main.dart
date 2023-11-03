import 'package:flutter/material.dart';
import 'package:team_player/pages/home.dart';
import 'package:team_player/pages/playlist_page.dart';
import 'package:team_player/pages/profile_page.dart';
import 'package:team_player/theme/theme_constants.dart';
import 'package:team_player/theme/theme_manager.dart';
import 'package:team_player/utils/dropbox.dart';
import 'package:team_player/utils/helpers.dart';


// Gradle = 7.5
// SDK = 30


ThemeManager _themeManager = ThemeManager();


void main(){
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({
    super.key,
});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    _themeManager.addListener(themeListner);
    super.initState();
  }

  @override
  void dispose() {
    _themeManager.removeListener(themeListner);
    super.dispose();
  }

  themeListner() {
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: darkTheme,
      //home: ShowAllThemeColors(context),
      home: Home(),
    );
  }
}

