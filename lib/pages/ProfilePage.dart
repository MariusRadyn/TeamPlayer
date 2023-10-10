import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    );
  }
}
