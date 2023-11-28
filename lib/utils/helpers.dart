import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_player/theme/theme_manager.dart';
import 'package:team_player/utils/global_data.dart';
import 'package:team_player/utils/constants.dart';

import 'database_manager.dart';
import 'firebase.dart';


List<String> getLinesFromTxtFile(String text) {
  List<String> lines = [];
  int startPos = 0;
  int endPos = 0;
  String line;

  while (endPos < text.length) {
    endPos = text.indexOf("\n",startPos+1);
    if (endPos == -1) break;

    line = text.substring(startPos, endPos).trim();
    startPos = endPos;
    lines.add(line);
  }
  return lines;
}
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

// -----------------------------------------------------------------------------
// Functions
// -----------------------------------------------------------------------------

saveAppSettings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(USER_NAME, appSettings.userName);
  prefs.setBool(DARK_THEME, appSettings.themeDark);
  prefs.setInt(NR_OF_COLUMNS, appSettings.nrOfColumns);
}

getAppSettings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  appSettings.userName = prefs.getString(USER_NAME) ?? '';
  appSettings.themeDark = prefs.getBool(DARK_THEME) ?? false;
  appSettings.nrOfColumns = prefs.getInt(NR_OF_COLUMNS) ?? 2;
}

removeSharedPreference(String propertyName) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(propertyName);
}

Future<SongViewModel> GetSongFromCloud(int index) async {
  List<String> _songWords = [];
  List<String> _songChords = [];
  List<Widget> _lstText = [];

  SongViewModel _songView = SongViewModel(
    songWords: _songWords,
    songChords: _songChords,
    lstText: _lstText,
  );

  String text = await fireReadFile(index);
  List<String> _lines = getLinesFromTxtFile(text);
  bool startOfChord = false;
  bool startOfChorus = false;

  for (String line in _lines)
  {
    // Title
    if(line.indexOf(tokenTitle) != -1){
      _songView.title = getToken(tokenTitle, line);
      _lstText.add(WriteSongLine(getToken(tokenTitle, line), songNameFontSize, Colors.white));
    }

    // Author
    else if(line.indexOf(tokenSubtitle) != -1) {
      _songView.author = getToken(tokenSubtitle, line);
      _lstText.add(WriteSongLine(getToken(tokenSubtitle, line), songAuthorFontSize, Colors.white24));
    }

    // Transpose, Version
    else if(line.indexOf(tokenEndOfSong) != -1) {
      _songView.transpose = getToken(tokenTranspose, text);
      _songView.version = getToken(tokenVersion, text);
      break;
    }

    // Song words and chords
    else {
      // {Start of Part}
      if(line.indexOf(tokenStartOfPart) != -1){
        _songWords.add(getToken(tokenStartOfPart, line));
        _songChords.add("");
        _lstText.add(WriteSongLine(getToken(tokenStartOfPart, line), songPartFontSize, Colors.white));
      }

      // {End of Part}
      else if(line.indexOf(tokenEndOfPart) != -1){
      }

      // {Comment}
      else if(line.indexOf(tokenComment) != -1){
        _songWords.add(getToken(tokenComment, line));
        _songChords.add("");
        _lstText.add(WriteSongLine(getToken(tokenComment, line), songWordFontSize, Colors.grey));
      }

      // {Start of Chorus}
      else if(line.indexOf(tokenStartOfChorus) != -1){
        startOfChorus = true;
        _songWords.add("Chorus");
        _songChords.add("");
        _lstText.add(WriteSongLine("Chorus", songPartFontSize, Colors.red));
      }

      // {End of Chorus}
      else if(line.indexOf(tokenEndOfChorus) != -1){
        startOfChorus = false;
      }

      // Words and Chords
      else{
        var lineChords = StringBuffer();
        var lineWords = StringBuffer();

        for(int i = 0; i < line.length;i++){
          if(line[i] == '[') {
            startOfChord = true;
            continue;
          }
          if(line[i] == ']') {
            startOfChord = false;
            continue;
          }
          if(startOfChord){
            lineChords.write(line[i]);
          }
          else {
            lineWords.write(line[i]);
            lineChords.write(" ");
          }
        }

        _songChords.add(lineChords.toString());
        _songWords.add(lineWords.toString());

        // Chords
        String _str = lineChords.toString();
        if(lineChords.toString() != "") {
          if(startOfChorus) _str = "  " + _str; // Indent Chorus
          _lstText.add(WriteSongLine(_str,songWordFontSize, Colors.deepOrangeAccent));
        }
        // Words
        _str = lineWords.toString();
        if(startOfChorus) _str = "  " + _str; // Indent Chorus
        _lstText.add(WriteSongLine(_str,songWordFontSize, Colors.white));
      }
    }
  }

  // Format Song
  //var _song = StringBuffer();
  // for(int i = 0;i < _songWords.length;i++){
  //   if(_songChords[i] != "") _song.write(_songChords[i] + "\n");
  //   _song.write(_songWords[i] + "\n");
  // }
  return _songView;
}

Text WriteSongLine(String text, double fontsize, Color color){
  return Text(text,
      style: TextStyle(
          fontFamily: 'SpaceMono',
          fontSize: fontsize,
          color: color
      )
  );
}

String getToken(String token, String text){
  int posEnd = 0;
  int posStart = text.indexOf(token);
  if (posStart == -1) return "";

  posEnd = text.indexOf("}", posStart + token.length);
  if(posEnd == -1) posEnd = text.indexOf("\n", posStart + token.length);
  if(posEnd == -1) posEnd = text.indexOf("\r", posStart + token.length);

  if(posEnd == -1) return text.substring(posStart + token.length).trim();
  else return text.substring(posStart + token.length, posEnd).trim();
}

// -----------------------------------------------------------------------------
// Widgets
// -----------------------------------------------------------------------------

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
  final IconData icon;
  final Color? iconColor;

  const MyTextFieldWithIcon({
    super.key,
    required this.textController,
    required this.text,
    this.onPressed,
    required this.icon,
    this.hint,
    this.iconColor,
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
            icon: Icon(
                icon,
                color: iconColor
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String text;
  final String? hint;
  final TextEditingController? textController;

  const MyTextField({
    super.key,
    required this.textController,
    required this.text,
    this.hint,
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
        ),
      ),
    );
  }
}

class MyDropdownButton extends StatelessWidget{
  List<String> lstValues;
  String dropdownValue;
  String label;
  IconData icon;
  String text;
  Function(String?)? onChange;

  MyDropdownButton({
   required this.lstValues,
   this.label = "",
   this.dropdownValue = "",
   this.icon = Icons.arrow_drop_down_sharp,
   this.onChange,
   required this.text,
});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,0,10,0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(text,
                style: const TextStyle(
                  fontSize: normalTextFontSize,
                ),
              ),
            ),

            Container(
              height: 30,
              width: 100,
              child: DropdownMenu<String>(
                label: Text(label),
                menuStyle: const MenuStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey),
                ),
                expandedInsets: EdgeInsets.fromLTRB(10,0,10,0),
                initialSelection: dropdownValue,
                onSelected: onChange,
                dropdownMenuEntries: lstValues.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                  );
                }).toList(),
              ),
            ),
          ],
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
      padding: const EdgeInsets.fromLTRB(10,0,10,0),
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

class MyListTile extends StatelessWidget {
  final String text;
  final String subText;
  Function()? onDelete;
  Function()? onTap;

  MyListTile({
    super.key,
    required this.text,
    this.subText = '',
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: ListTile(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.blueGrey, width: 1),
            borderRadius: BorderRadius.circular(25),
          ),
          // Delete Icon
          trailing: IconButton(
            onPressed: onDelete,
            icon: const Icon(
            Icons.delete_forever,
            color: Colors.red,
            size: 30,
            ),
          ),
          title: Text(text, overflow: TextOverflow.ellipsis),
          subtitle: Text(subText, overflow: TextOverflow.ellipsis),
          onTap: onTap,

        ),
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
       padding: const EdgeInsets.fromLTRB(10,0,10,0),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Text(label,
             style: const TextStyle(fontSize: normalTextFontSize,
             ),
           ),
           Switch(
             value: switchState,
             onChanged: onChanged
           ),
         ],
       ),
     );
   }
}

class MyTextButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;

  const MyTextButton({
    super.key,
    this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10,5,10,0),
          child: Text(text,
            style: const TextStyle(
              fontSize: normalTextFontSize,
            ),
          ),
        ),
    );
  }
}

class MyAlertDialogBox extends StatelessWidget {
  final String heading;
  final String msg;
  final String but1Text;
  final String but2Text;
  final Function()? onPressedBut1;
  final Function()? onPressedBut2;
  final BuildContext context;

  const MyAlertDialogBox({
    super.key,
    required this.heading,
    required this.msg,
    this.onPressedBut1,
    this.onPressedBut2,
    this.but1Text = "",
    this.but2Text = "",
    required this.context,
  });

  _alert(){
    var v = AlertDialog(
      title: Text(heading),
      content: Text(msg),
      actions: <Widget>[
        TextButton(
          child: Text(but1Text),
          onPressed: onPressedBut1,
        ),
        TextButton(
          child: Text(but2Text),
          onPressed: onPressedBut2,
        ),
      ],
    );
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return v;
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return _alert();
  }
}

class MyDialogBox{
  final String message;
  final String header;
  final String but1Text;
  final String but2Text;
  final VoidCallback? onPressedBut1;
  final VoidCallback? onPressedBut2;
  String image;

  MyDialogBox({
    required this.message,
    required this.header,
    required this.but1Text,
    required this.but2Text,
    this.onPressedBut1,
    this.onPressedBut2,
    this.image = "images/warning.png",
  });

   Future<void> dialogBuilder(BuildContext context) {
     return showDialog<void>(
       context: context,
       builder: (BuildContext context) {
         return CupertinoAlertDialog(
           title: Row(
             children: [
               Expanded(
                 flex: 1,
                 child: Image.asset(
                   image,
                   height: 30,
                   width: 30,
                 ),
               ),
               SizedBox(width: 20),
               Expanded(
                   flex: 4,
                   child: Text (
                     header,
                     textAlign: TextAlign.start,
                   )
               ),
             ],
           ),
           content: Text(
             message,
             textAlign: TextAlign.center,
           ),
           actions: <Widget>[
             TextButton(
               style: TextButton.styleFrom(
                 textStyle: Theme.of(context).textTheme.labelLarge,
               ),
               child: Text(but1Text),
               onPressed: onPressedBut1,
             ),
             TextButton(
               style: TextButton.styleFrom(
                 textStyle: Theme.of(context).textTheme.labelLarge,
               ),
               child: Text(but2Text),
               onPressed: onPressedBut2,
             ),
           ],
         );
       },
     );
   }
 }

class MyMessageBox{
  final String message;
  String image;

  MyMessageBox({
    required this.message,
    this.image = "",
  });

  Future<void> dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text("OK"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class MyShowSongScreen extends StatelessWidget {
  final List<Widget> lstText;
  final String heading;

  MyShowSongScreen({
    required this.lstText,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(heading)),
      body: Center(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: lstText
        ),
      ),
    );
  }
}

class SongViewModel {
  String title;
  String author;
  String version;
  String transpose;
  String originalChord;
  List<String> songWords;
  List<String> songChords;
  List<Widget> lstText;

  SongViewModel({
    this.title = "",
    this.author = "",
    this.transpose = "",
    this.originalChord = "",
    this.version = "",
    required this.songWords,
    required this.songChords,
    required this.lstText,
  });
}

