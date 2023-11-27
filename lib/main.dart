import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:team_player/pages/home.dart';
import 'package:team_player/theme/theme_manager.dart';
import 'package:team_player/utils/helpers.dart';
import 'package:team_player/utils/global_data.dart';
import 'package:team_player/utils/firebase.dart';


// Gradle = 7.5
// SDK = 30


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await getAppSettings();
  await Firebase.initializeApp();
  await fireGetFilesList("/user1");
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
    getAppSettings();
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
      home: Home(),
    );
  }
}

