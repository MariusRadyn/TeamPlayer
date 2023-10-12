import 'package:flutter/material.dart';
import 'package:team_player/utils/playListItem.dart';
import 'package:team_player/utils/playListItem.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {


  final List _playList = [
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

      final tile = _playList.removeAt(oldIndex);
      _playList.insert(newIndex, tile);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.05);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.10);

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
     body: ReorderableListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        itemCount: _playList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            key: Key('$index'),
            tileColor: index.isOdd ? oddItemColor : evenItemColor,
            title: Text(_playList[index]),
          );
        },
        onReorder: (int oldIndex, int newIndex) => reorderItems(oldIndex, newIndex),
         //children: [
           // for (final song in platList)
           //   ListTile(
           //     key: ValueKey(song),
           //     title: PlayListItem(
           //         text: song,
           //       onDelete: (){},
           //     ),
           //   )
          )
         //],
         //onReorder: (oldIndex, newIndex) => reorderItems(oldIndex, newIndex),
       
     //),
    );
  }
}
