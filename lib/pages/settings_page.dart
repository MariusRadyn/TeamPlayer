import 'package:flutter/material.dart';
import 'package:team_player/main.dart';
import 'package:team_player/utils/global_data.dart';
import 'package:team_player/utils/global_data.dart';
import 'package:team_player/utils/database_manager.dart';
import 'package:team_player/utils/helpers.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _cntrButton1 = TextEditingController();
  final textCntrNrOfColumns = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsHeader("General", Theme.of(context).highlightColor),
          MySwitchWithLabel(
              switchState: themeManager.themeMode == ThemeMode.dark,
              label: "Dark Theme",
              onChanged: (bool newVal) {
                setState(() {
                  themeManager.toggleTheme(newVal);
                });
              }),
          MyDropdownButton(
            text: 'Number of Columns',
            label: 'Columns',
            lstValues: ['1', '2', '3'],
            dropdownValue: appSettings.nrOfColumns.toString(),
            onChange: (String? value) {
              setState(() {
                appSettings.nrOfColumns = int.parse(value!);
                saveAppSettings();
              });
            },
          ),
          const SizedBox(height: 20),
          SettingsHeader("Database Settings", Theme.of(context).highlightColor),
          // Delete  Database?
          MyTextButton(
            text: "Delete local Database",
            onPressed: () {
              MyDialogBox box = MyDialogBox(
                  header: 'WARNING',
                  message: 'This will delete the local Database '
                      'Nothing will be deleted from the cloud '
                      'All local data that was not pushed to cloud will be lost '
                      'Do a new "SYNC" to restore cloud to local library\n\n'
                      'Are you sure?',
                  but1Text: "YES",
                  but2Text: "NO",
                  image: 'images/warning.png',
                  onPressedBut1: () {
                    dbDeleteDatabase();
                    Navigator.of(context).pop();
                    MyMessageBox(message: "Database deleted")
                        .dialogBuilder(context);
                  },
                  onPressedBut2: () {
                    Navigator.of(context).pop();
                  });
              box.dialogBuilder(context);
            },
          ),
          //MyTextFieldWithIcon(
          //   text: 'Dropbox',
          //   textController: _cntrButton1,
          //   icon: Icons.delete_forever,
          //   iconColor: Theme.of(context).primaryColor,
          // ),
        ],
      ),
    );
  }
}

Padding SettingsHeader(String header, Color color) {
  return Padding(
    padding: EdgeInsets.fromLTRB(5, 10, 10, 0),
    child: Text(
      header,
      style: TextStyle(
        color: color,
        fontSize: headerTextFontSize,
      ),
    ),
  );
}

bool hasTextOverflow(String text, TextStyle style, {double minWidth = 0, double maxWidth = double.infinity, int maxLines = 2}) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(
        text: text,
        style: style
    ),
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: minWidth, maxWidth: maxWidth);
  return textPainter.didExceedMaxLines;
}
