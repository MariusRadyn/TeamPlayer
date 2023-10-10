import 'package:flutter/material.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
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
        title: const Text('Play List',
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
