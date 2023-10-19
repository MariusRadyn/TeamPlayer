import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget AddVericalSpace(double height){
  return SizedBox(
    height: height,
  );

}Widget AddHorisontalSpace(double width){
  return SizedBox(
    width: width,
  );
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