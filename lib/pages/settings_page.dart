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
          Padding(
            padding: const EdgeInsets.fromLTRB(10,10,10,0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Dark Theme',
                  style: TextStyle(
                    fontSize: 18,
                  ),

                ),
                Switch(
                  value: themeManager.themeMode == ThemeMode.dark,
                  onChanged: (bool newVal) {
                    setState(() {
                      themeManager.toggleTheme(newVal);
                    });
                  }),
              ],
            ),
          ),
          MyTextField('Dropbox', _cntrButton1),
          MaterialButton(onPressed: () {})
        ],
      ),
    );
  }
}

