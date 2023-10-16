import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:team_player/theme/theme_constants.dart';
import 'package:team_player/utils/playlist_Item.dart';
import 'package:team_player/utils/playlist_Item.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}
enum Actions{share,delete,archive}

class _PlaylistPageState extends State<PlaylistPage> {

  final List<PlayListData> _playList = [
    PlayListData(
        songname: 'How great is our God',
        writer: 'Chris Tomlin'),
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
  void initState() {
    _playList.add(PlayListData(
      songname: 'Rain',
      writer: 'Leeland')
    );

    _playList.add(PlayListData(
      songname: 'Indescribible',
      writer: 'Chris Tomlin')
    );
    super.initState();
  }

  void _onDismissed(int index, Actions action)
  {
    final song = _playList[index];

    if(action == Actions.delete){
      setState(() => {
        _playList.removeAt(index)
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.25);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.30);

    TextTheme _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text('Playlist'),
      ),

     body: ReorderableListView.builder(

        itemCount: _playList.length,
        itemBuilder: (BuildContext context, int index) {
          //return Slidable(
              //key: ValueKey(_playList[index]),
              // startActionPane: ActionPane(
              //   motion: const StretchMotion(),
              //   children: [
              //     SlidableAction(
              //     onPressed: (context)=>_onDismissed(index, Actions.archive),
              //     backgroundColor: Colors.greenAccent,
              //     icon: Icons.access_alarm,
              //     label: 'archive',
              //   ),
              //     SlidableAction(
              //       onPressed: (context)=>_onDismissed(index, Actions.share),
              //       backgroundColor: Colors.blueAccent,
              //       icon: Icons.access_alarm,
              //       label: 'Label2',
              //     ),
              //   ],
              // ),
              // endActionPane:ActionPane(
              //   motion: BehindMotion(),
              //   children: [
              //     SlidableAction(
              //       onPressed: (context)=>_onDismissed(index, Actions.delete),
              //       backgroundColor: Colors.redAccent,
              //       icon: Icons.access_alarm,
              //       label: 'Delete',
              //     ),
              //   ],
              // ) ,
              //child: PlayListItem(text: _playList[index].songname)
          //);

            return ListTile(
             key: Key('$index'),
        //     backgroundColor : index.isOdd ? oddItemColor : evenItemColor,
        //     backgroundColorActivated: COLOR_DARK_PRIMARY,
        //     padding: EdgeInsets.fromLTRB(15, 2, 2, 2),
        //
             title: Text(
               _playList[index].songname,
               style: TextStyle(color: Colors.white),
             ),
             subtitle: Text(_playList[index].writer,
               style: const TextStyle(
                   color: Colors.white38,
                   fontStyle: FontStyle.italic,
                   fontSize: 15.0,
               ),
             ),

           );
         },
         onReorder: (int oldIndex, int newIndex) => reorderItems(oldIndex, newIndex),
         // children: [
         //    for (final song in _playList)
         //      ListTile(
         //        key: ValueKey(song),
         //        title: PlayListItem(
         //            text: song.songname,
         //          onDelete: (){},
         //        ),
         //      )
         //  ]
     ),
         //],

     //),
    );


  }
}



class PlayListData {
  final String songname;
  final String writer;

  PlayListData({
    required this.songname,
    required this.writer,}
  );
}