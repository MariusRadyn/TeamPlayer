import 'package:flutter/material.dart';
import 'package:team_player/utils/helpers.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final _cntrUserName = TextEditingController();
  final _cntrUserSurname = TextEditingController();

  String txtUserName = '';
  String txtUserSurname = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyTextFieldWithIcon(
              text: 'Name',
              textController: _cntrUserName,
              icon: Icon(Icons.delete_forever),
            ),

            SizedBox(height: 10.0),

            MyTextFieldWithIcon(
              text: 'Surname',
              textController: _cntrUserSurname,
              icon: Icon(Icons.delete_forever),
            ),

            MaterialButton(
              onPressed: (){
                setState(() {
                  txtUserName = _cntrUserName.text;
                });
              },
              color: Colors.blue,
              child: const Text('Save',
                  style: TextStyle(
                      color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
