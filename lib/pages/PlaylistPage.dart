import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:team_player/theme/theme_constants.dart';
import 'package:team_player/utils/playListItem.dart';
import 'package:team_player/utils/playListItem.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {

  final List<c_PlayList> _playList = [
    // 'Yahwe - Bethel',
    // 'Jira - Hilsong',
    // 'Let it Rain - Chris McLarne',
    // 'Listen - Bethel',
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

    TextTheme _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('Playlist'),
      ),

     body: ReorderableListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        itemCount: _playList.length,
        itemBuilder: (BuildContext context, int index) {
          return CupertinoListTile(
            key: Key('$index'),
            backgroundColor : index.isOdd ? oddItemColor : evenItemColor,
            backgroundColorActivated: COLOR_DARK_PRIMARY,
            title: Text(
              _playList[index],
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text('test',
              style: TextStyle(
                  color: Colors.white38,
                  fontStyle: FontStyle.italic,
                  fontSize: 15.0,
              ),
            ),
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
class c_PlayList{
  final String SongName;
  final String Writer;

  c_PlayList(
    this.SongName,
    this.Writer,
  );
}

}