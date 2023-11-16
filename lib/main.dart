import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:team_player/pages/home.dart';
import 'package:team_player/theme/theme_manager.dart';
import 'package:team_player/utils/dropbox.dart';
import 'package:firebase_storage/firebase_storage.dart';


// Gradle = 7.5
// SDK = 30


ThemeManager themeManager = ThemeManager();


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    themeManager.addListener(themeListner);
    themeManager.toggleTheme(true);
    super.initState();
  }

  @override
  void dispose() {
    themeManager.removeListener(themeListner);
    super.dispose();
  }

  themeListner() {
    if (mounted) {
      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      //home: ShowAllThemeColors(context),
      home: Home(),
    );
  }
}

