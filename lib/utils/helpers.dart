import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_player/utils/global_data.dart';
import 'package:team_player/theme/theme_manager.dart';


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

MaterialButton myButton(String text, Function()? onPressed) {
  return MaterialButton(
    onPressed: onPressed,
    color: Colors.blue,
    child: Text(text,
        style: const TextStyle(
            color: Colors.white)),
  );
}

class MyTextFieldWithIcon extends StatelessWidget {
  final String text;
  final String? hint;
  final TextEditingController? textController;
  final Function()? onPressed;
  final Widget icon;

  const MyTextFieldWithIcon({
    super.key,
    required this.textController,
    required this.text,
    this.onPressed,
    required this.icon,
    this.hint
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,0,10,0),
      child: TextField(
        controller: textController,
        decoration: InputDecoration(
          hintText: hint,
          labelText: text,
          border: UnderlineInputBorder(),
          suffixIcon: IconButton(
            onPressed: onPressed,
            icon: icon,
          ),
        ),
      ),
    );
  }
}

class MyTextTile extends StatelessWidget {
  final Color? color;
  final String text;

  const MyTextTile({
    super.key,
    this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 400,
        height: 50,
        color: color,
        child: Center(
          child: Text(text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class MyPlayListItem extends StatelessWidget {
  final String text;
  final String subText;
  Function()? onDelete;

  MyPlayListItem({
    super.key,
    required this.text,
    this.subText = '',
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5,2,0,0),
                child: Text(text,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: COLOR_DARK_ONPRIMARY),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5,0,0,0),
                child: Text(subText,
                  style: const TextStyle(color: Colors.white38),
                ),
              ),
            ],
          ),
          Expanded(
            child: IconButton(
                alignment: Alignment.centerRight,
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                  size: 30,
                )
            ),
          )
        ],
      ),
    );
  }
}

 class MySwitchWithLabel extends StatelessWidget {
   const MySwitchWithLabel({
     Key? key,
     this.onChanged,
     required this.switchState,
     required this.label,
   }) : super(key: key);

   final String label;
   final Function(bool)? onChanged;
   final bool switchState;

   @override
   Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.fromLTRB(10,10,10,0),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text(label,
             style: const TextStyle(fontSize: 18,
             ),
           ),
           Switch(
             value: switchState,
             onChanged: onChanged,
             activeColor: Theme.of(context).primaryColor,
           ),
         ],
       ),
     );
   }
}




