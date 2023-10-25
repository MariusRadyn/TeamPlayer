import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:team_player/views/song_view.dart';
import 'package:team_player/utils/database_manager.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  final _controller = PageController();

  @override
  void initState() {
    initDB();
    super.initState();
  }

  Future initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'LocalDB.db');
    Database db = await DatabaseHelper().db;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(2, 10, 2, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Expanded(
                 child: Container(
                   height: MediaQuery.of(context).size.height-100,
                   child: PageView(
                     controller: _controller,
                     scrollDirection: Axis.horizontal,
                     children: [
                       SongContainer(text: 'Song 1'),
                       SongContainer(text: 'Song 2'),
                     ],
                   ),
                 ),
               ),

              const SizedBox(height: 15),

              SmoothPageIndicator(
                controller: _controller,
                count: 2,
                effect: WormEffect(
                  dotColor: Theme.of(context).colorScheme.primary,
                  activeDotColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

