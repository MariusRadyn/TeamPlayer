import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
        title: Text('Settings',
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
