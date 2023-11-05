import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:team_player/utils/global_data.dart';
import 'package:team_player/utils/playlist_Item.dart';
import '../bars/bottomNavBarHome.dart';
import 'package:team_player/utils/database_manager.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({super.key});

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}
enum Actions{share,delete,archive}

class _PlaylistPageState extends State<PlaylistPage> {

  void reorderItems(int oldIndex, int newIndex){
    setState(() {
      // Fix error when moving down
      if(oldIndex < newIndex) newIndex--;

      final tile = myPlayList.removeAt(oldIndex);
      myPlayList.insert(newIndex, tile);
    });
  }

  // Database
  List<Map<String, dynamic>> _playList = [];
  bool _isLoading = true;
  void getPlayList() async {
    final data = await dbReadTable(DB_TABLE_PLAYLIST_ITEMS);
    setState(() {
      _playList = data;
      _isLoading = false;
    });
    print(_playList);
  }

  void loadDummyData() {
    LocalPlaylistLibrary data = LocalPlaylistLibrary(
      id: 0,
      description: 'My New Playlist',
      nrOfItems: 0,
      dateCreated: DateTime.now().toString(),
      dateModified: DateTime.now().toString(),
    );

    dbInsert(DB_TABLE_PLAYLIST_ITEMS, data);
  }

  @override
  void initState() {
    //deleteLocalDB();
    //loadDummyData();
    getPlayList();
    super.initState();
  }

  void _onDismissed(int index, Actions action){
    final song = myPlayList[index].songName;
    if(action == Actions.delete){
     setState(() => {
       myPlayList.removeAt(index)
     });
    }
  }

  ListTile PlayListTile(int index){
    return ListTile(
      key: Key('$index'),
      title: MyPlayListItem(
        text: _playList[index]['description'],
        subText: 'Items: ' + _playList[index]['nrOfItems'],
        onDelete: (){
          setState(() {
            _playList.removeAt(index);
          });
        },
      ),
    );
  }

  Slidable slideList(int index){
    return Slidable(
    key: ValueKey(index),
    startActionPane: ActionPane(
      motion: const StretchMotion(),
      children: [
        SlidableAction(
        onPressed: (context)=>_onDismissed(index, Actions.archive),
        backgroundColor: Colors.greenAccent,
        icon: Icons.access_alarm,
        label: 'archive',
      ),
        SlidableAction(
          onPressed: (context)=>_onDismissed(index, Actions.share),
          backgroundColor: Colors.blueAccent,
          icon: Icons.access_alarm,
          label: 'Label2',
        ),
      ],
    ),
    endActionPane:ActionPane(
      motion: BehindMotion(),
      children: [
        SlidableAction(
          onPressed: (context)=>_onDismissed(index, Actions.delete),
          backgroundColor: Colors.redAccent,
          icon: Icons.access_alarm,
          label: 'Delete',
        ),
      ],
    ) ,
    child: MyPlayListItem(text: myPlayList[index].songName)
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.25);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.30);
    TextTheme _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist'),
      ),
      bottomNavigationBar: BottomNavBarHome(),
      body: ReorderableListView.builder(
       onReorder: (int oldIndex, int newIndex) => reorderItems(oldIndex, newIndex),
       itemCount: _playList.length,
       itemBuilder: (BuildContext context, int index) {
         return PlayListTile(index);
       },
     ),
    );
  }
}