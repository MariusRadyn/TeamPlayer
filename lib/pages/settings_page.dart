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
              MyDialogBox box = MyDialogBox(
                  header: 'WARNING',
                  message: 'This will delete the local Database '
                      'Nothing will be deleted from the cloud '
                      'All local data that was not pushed to cloud will be lost '
                      'Do a new "SYNC" to restore cloud to local library\n\n'
                      'Are you sure?',
                but1Text: "YES",
                but2Text: "Cancel",
                image: 'images/warning.png',
                onPressedBut1:(){
                    dbDeleteDatabase();
                    Navigator.of(context).pop();
                    MyMessageBox(message: "Database deleted" ).dialogBuilder(context);
                },
              );
              box.dialogBuilder(context);
            },
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

