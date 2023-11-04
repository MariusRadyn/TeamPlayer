import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:team_player/utils/global_data.dart';
import 'package:team_player/views/song_view.dart';
import 'package:team_player/utils/database_manager.dart';

SQLHelperSongsLibrary myDB = SQLHelperSongsLibrary();

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
    Database db = await myDB.database;
    var data = const LocalSongsLibrary(
      id: 1,
      songName: 'How great is our God',
      author: 'Chris Tomlin',
      genre: 'Cristian',
      dateModified: '10/10/2002',
      isActive: 0,
    );

    await SQLHelperSongsLibrary.insert(data);
    List<Map> list = await db.rawQuery('SELECT * FROM $DB_TABLE_SONGS_LIB');
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

