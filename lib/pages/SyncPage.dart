import 'package:flutter/material.dart';

class SyncPage extends StatefulWidget {
  const SyncPage({super.key});

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
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
        title: Text('Sync',
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
