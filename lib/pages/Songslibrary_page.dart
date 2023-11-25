
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/database_manager.dart';
import '../utils/global_data.dart';
import 'package:team_player/utils/helpers.dart';
//import 'package:dropbox_client/dropbox_client.dart';
import 'package:team_player/utils/firebase.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({super.key});

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  List<BottomNavigationBarItem> navBarItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(label: 'Add', icon: Icon(Icons.add)),
    const BottomNavigationBarItem(label: 'Edit', icon: Icon(Icons.edit)),
    const BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
    const BottomNavigationBarItem(label: 'Sync', icon: Icon(Icons.sync)),
  ];

  int _selectedIndex = 0;


  Future initDropbox() async{
    //await Dropbox.init('Team_Player' , 'ilzt9kfjbiv4ofw', 'd0swgoachzofagc');
  }

  @override
  void initState() {
    super.initState();
    //dbDeleteDatabase();
    //loadDummyData();
    //getSongLibrary();
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   fireGetFilesList("/user1");
    // });
  }

  ListTile PlayListTile(int index){
    return ListTile(
      key: Key('$index'),
      title: MyListTile(
        onTap: (){
          _onTap(index);
        },
        text: fireAllSongsRef[index].name,
        subText: fireAllSongsRef[index].fullPath,
        onDelete: (){
          setState(() {
            String song = fireAllSongsRef[index].name;
            MyDialogBox(
              header: "Delete Song?",
              message: "$song\n\n Delete this song permanently from the cloud\nAre you Sure?",
              but1Text: "Yes",
              but2Text: "No",
              onPressedBut1: (){
                fireAllSongsRef.removeAt(index);
                Navigator.of(context).pop();
                setState(() {});
                },
            ).dialogBuilder(context);
          });
        },
      ),
    );
  }

  void reorderItems(int oldIndex, int newIndex){
    setState(() {
      // Fix error when moving down
      if(oldIndex < newIndex) newIndex--;
      final tile = myPlayList.removeAt(oldIndex);
      myPlayList.insert(newIndex, tile);
    });
  }

  // Read Database
  List<Map<String, dynamic>> _songsLibrary = [];
  bool _isLoading = true;
  void getSongLibrary() async
  {
    final data = await dbReadTable(DB_TABLE_SONGS_LIB);
    setState(() {
      _songsLibrary = data;
      _isLoading = false;
    });
    print(_songsLibrary);
  }

  void loadDummyData() {
     LocalSongsLibrary data = LocalSongsLibrary(
        id: 0,
        songName: 'How great is our God',
        author: 'Chris Tomlin',
        genre: 'Christian',
        dateCreated: DateTime.now().toString());

     dbInsert(DB_TABLE_SONGS_LIB, data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library',
           // style: TextStyle(
           //     fontFamily: 'SpaceMono',
           //     fontWeight: FontWeight.normal
           // ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: navBarItems,
        currentIndex: _selectedIndex,
        onTap: _onNavBarTapped,
      ),
      body: ListView.builder(
        itemCount: fireAllSongsRef.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key('$index'),
            child: PlayListTile(index),
            onDismissed: (direction) {
              setState(() {
                fireAllSongsRef.removeAt(index);
              });

              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(
                      content: Text('item deleted')
              ));
            },
          );
        },
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context, SongViewModel view) {

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyShowSongScreen (
      text: view.songFormatted.toString(),
      heading: view.title,
    )));
  }

  Future<void> _onTap(int index) async{
    SongViewModel _songview = await GetSongFromCloud(index);
    _navigateToNextScreen(context, _songview);
  }


  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
