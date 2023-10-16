import 'package:flutter/material.dart';

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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData(
          size: 40.0,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[700],
        title: const Text('Profile',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Expanded(
            //     child: Container(
            //       child: Text(_cntrUserName.text),
            //     )
            // ),
            TextField(
              controller: _cntrUserName,
              decoration: InputDecoration(
                hintText: 'Name',
                border: UnderlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: (){
                    _cntrUserName.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _cntrUserSurname,
              decoration: InputDecoration(
                hintText: 'Surname',
                border: UnderlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: (){
                    _cntrUserSurname.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            MaterialButton(
              onPressed: (){
                setState(() {
                  txtUserName = _cntrUserName.text;
                });
              },
              color: Colors.blue,
              child: Text('Save',
                  style: TextStyle(
                      color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
