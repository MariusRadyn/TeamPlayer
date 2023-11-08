import 'package:flutter/material.dart';
import 'package:team_player/main.dart';
import 'package:team_player/theme/theme_manager.dart';
import 'package:team_player/utils/database_manager.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.fromLTRB(10,10,10,10),
            child: Text("Database Settings",
              style: TextStyle(
                color: Theme.of(context).highlightColor,
                fontSize: 16,
              ),
            ),
          ),
          MyTextButton(
            text: "Delete local Database",
            onPressed: (){
              MyAlertDialogBox(
                heading: "WARNING!",
                msg: "This will delete your local synched Database\nAre you sure?",
                but1Text: "Yes",
                but2Text: 'No',
                onPressedBut1: (){
                  dbDeleteDatabase();
                },
              );
            }
          ),
          MyTextFieldWithIcon(
            text: 'Dropbox',
            textController: _cntrButton1,
            icon: Icons.delete_forever,
            iconColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}

