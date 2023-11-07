import 'package:flutter/material.dart';
import 'package:team_player/main.dart';
import 'package:team_player/utils/helpers.dart';



class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _cntrButton1 = TextEditingController();
  bool isDarkTheme = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          MySwitchWithLabel(
            switchState: themeManager.themeMode == ThemeMode.dark,
            label: "Dark Theme",
            onChanged: (bool newVal) {
              setState(() {
                themeManager.toggleTheme(newVal);
              });
            }
          ),
          MyTextFieldWithIcon(
            text: 'Dropbox',
            textController: _cntrButton1,
            icon: Icon(Icons.delete_forever),
          ),
          MaterialButton(onPressed: () {})
        ],
      ),
    );
  }
}

