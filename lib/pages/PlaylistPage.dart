import 'package:flutter/material.dart';
import 'package:team_player/utils/playListItem.dart';
import 'package:team_player/utils/playListItem.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {

  final List songList = [
    'How Great is God - Chris Tomlin',
    'Yahwe - Bethel',
    'Jira - Hilsong',
    'Let it Rain - Chris McLarne',
    'Listen - Bethel',
  ];

  void reorderItems(int oldIndex, int newIndex){
    setState(() {

      // Fix error when moving down
      if(oldIndex < newIndex) newIndex--;

      final tile = songList.removeAt(oldIndex);
      songList.insert(newIndex, tile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(size: 40.0,color: Colors.white,),
        backgroundColor: Colors.blue[900],
        title: const Text('Play List',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
     body: ReorderableListView(
         children: [
           for (final song in songList)
             ListTile(
               key: ValueKey(song),
               title: PlayListItem(
                   text: song,
                 onDelete: (){},
               ),
             )
         ],
         onReorder: (oldIndex, newIndex) => reorderItems(oldIndex, newIndex),
       
     ),
    );
  }
}
