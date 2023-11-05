import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_player/utils/global_data.dart';

Future<void> MySimpleDialog(BuildContext context) {
  return
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Text("Title"),
          children: <Widget>[
            SimpleDialogOption(child: Text("Option1"), onPressed: () {}),
            SimpleDialogOption(child: Text("Option2"), onPressed: () {}),
            SimpleDialogOption(child: Text("Option3"), onPressed: () {})
          ],
        );
      },
    );
}


Future<void> MyAlertDialog(BuildContext context, String heading, String msg) {
  return showDialog (
    context: context,
    builder: (context) {
      return AlertDialog (
        title: Text(heading),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            child: const Text('Yes'),
            onPressed: () {

            },
          ),
          TextButton(
            child: const Text('No'),
            onPressed: () {
            },
          ),
        ],
      );
    },
  );
}

saveUserSettings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(USER_NAME, userSettings.userName);
  prefs.setBool(DARK_THEME, userSettings.themeDark);
}

getUserSettings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userSettings.userName = prefs.getString(USER_NAME) ?? '';
  userSettings.themeDark = prefs.getBool(DARK_THEME) ?? false;
}

removePreference(String propertyName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(propertyName);
}

Container ShowAllThemeColors(BuildContext context){
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyTextTile('Primary', Theme.of(context).colorScheme.primary),
          MyTextTile('OnPrimary', Theme.of(context).colorScheme.onPrimary),
          MyTextTile('Secondary', Theme.of(context).colorScheme.secondary),
          MyTextTile('OnSecondary', Theme.of(context).colorScheme.onSecondary),
          MyTextTile('Background', Theme.of(context).colorScheme.background),
        ],
      ),
    ),
  );
}

TextField MyTextField(String text, TextEditingController _cntr){
  return TextField(
    controller: _cntr,
    decoration: InputDecoration(
      hintText: text,
      labelText: 'label',
      border: UnderlineInputBorder(),
      suffixIcon: IconButton(
        onPressed: (){
          _cntr.clear();
        },
        icon: const Icon(Icons.clear),
      ),
    ),
  );
}

MaterialButton MyButton(String text, Function()? onPressed) {
  return MaterialButton(
    onPressed: onPressed,
    color: Colors.blue,
    child: Text(text,
        style: const TextStyle(
            color: Colors.white)),
  );
}

 Padding MyTextTile(String txt, Color color){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 400,
      height: 50,
      color: color,
      child: Center(
        child: Text(txt,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
 }


// Future<Database> _db;
//
// Future<Database> getDataBase() async {
//   _db = _db ?? openDatabase(join(await getDatabasesPath(), 'data.db');
//       return _db;
//   }
// getData() async {
//   final Database db = await getDataBase();
// }

