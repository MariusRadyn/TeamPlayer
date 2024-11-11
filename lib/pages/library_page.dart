
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:path_provider/path_provider.dart';
import '../utils/database_manager.dart';
import '../utils/global_data.dart';
import 'package:team_player/utils/helpers.dart';
import 'package:team_player/utils/song_view_model.dart';
import 'package:team_player/utils/firebase.dart';

enum Actions{
  share,
  delete,
  archive
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}
class _LibraryPageState extends State<LibraryPage> {
  List<BottomNavigationBarItem> navBarItems = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(label: 'Add', icon: Icon(Icons.add)),
    const BottomNavigationBarItem(label: 'Edit', icon: Icon(Icons.edit)),
    const BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
    const BottomNavigationBarItem(label: 'Sync', icon: Icon(Icons.sync)),
  ];

  int _selectedIndex = 0;
  List<Map<String, dynamic>> _songsLibrary = [];
  bool _isLoading = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library',
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
             child: MySlidableListTile(
              index: index,
              textHeader: fireAllSongsRef[index].name,
              subText: "Author",

              //On Tap
              onTap: () => _onTap(index),

              // On Share
              onShare: (context) => {print('onShare')},

              // On Sync
              onSync: (context) => {print('onSync')},

              //On Delete
              onDelete: (context) => {
                setState(() {
                  String song = fireAllSongsRef[index].name;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                      MyDialogWidget(
                        message: "$song\n\n Move this song to the Recycle Bin\nAre you Sure?",
                        header: "Move Song to Recycle Bin?",
                        but1Text: "Yes",
                        but2Text: "No",
                        onPressedBut1:() {
                          Navigator.of(context).pop();
                          //fireUploadImage("");
                          //fireUploadFile("C:\\Temp\\script.txt");
                          MoveSongToRecyclebin(context, fireAllSongsRef[index].fullPath);
                          fireAllSongsRef.removeAt(index);
                          setState(() {});
                        },
                        onPressedBut2: (){
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  );
                }),
              },// On Delete
            ),
          );
        },
      ),
    );
  }

  // Methods -------------------------------------------------------------------

  Future initDropbox() async{
    //await Dropbox.init('Team_Player' , 'ilzt9kfjbiv4ofw', 'd0swgoachzofagc');
  }
  void MoveSongToRecyclebin(BuildContext context, String filename) async {
    final directory = await getDownloadsDirectory();
    File path = File('$directory.path/$filename');
    new Directory('testDir').create();
    path.writeAsString('$path');

    final exist = await path.exists();
    if(!exist){
      Navigator.push(
        context,
          MaterialPageRoute(
          builder: (context) =>
            MyAlertDialogBox(
              context: context,
              heading: "File not found",
              msg: "File not found: $path",
              but2Text: "OK",
            ),
          ),
      );
      Navigator.pop(context);
    }
    else
      fireUploadFile('$path');
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
  ListTile PlayListTileSlide(int index){
    return ListTile(
      key: Key('$index'),
      title: slideList(index),
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
        child : MyListTile(
            text: fireAllSongsRef[index].name)
    );
  }
  void _onDismissed(int index, Actions action){
    final song = myPlayList[index].songName;
    if(action == Actions.delete){
      fireUploadFile(song);
      setState(() => {
        myPlayList.removeAt(index)
      });
    }
  }

  void getSongLibrary() async {
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
  void _navigateToNextScreen(BuildContext context, SongViewModel view) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ViewSong (
          songView: view,
        )
    ));
  }
  Future<void> _onTap(int index) async{
    SongViewModel _songview = await getSongFromCloud(index);
    _navigateToNextScreen(context, _songview);
  }
  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
