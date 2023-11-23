
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
        title: const Text('Library'),
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
    List<String> _songWords = [];
    List<String> _songChords = [];
    List<String> _songFormatted = [];
    SongViewModel _songView = SongViewModel(
        songWords: _songWords,
        songChords: _songChords,
        songFormatted: _songFormatted,
    );

    String text = await fireReadFile(index);
    List<String> _lines = getLinesFromTxtFile(text);

    int startPos = 0;
    int endPos = 0;
    bool startOfChord = false;

    for (String line in _lines)
      {
        if(line.indexOf(tokenTitle) != -1) _songView.title = getToken(tokenTitle, line);
        else if(line.indexOf(tokenSubtitle) != -1) _songView.author = getToken(tokenSubtitle, line);
        else if(line.indexOf(tokenEndOfSong) != -1) {
          _songView.transpose = getToken(tokenTranspose, text);
          _songView.version = getToken(tokenVersion, text);
          break;
        }
        else {
          // Format Song
          // Start of Part
          if(line.indexOf(tokenStartOfPart) != -1){
            _songWords.add(getToken(tokenStartOfPart, line));
            _songChords.add("");
          }
          // End of Part
          else if(line.indexOf(tokenEndOfPart) != -1){
            _songWords.add("");
            _songChords.add("");
          }
          else if(line.indexOf(tokenStartOfChorus) != -1){
            _songWords.add("Chorus");
            _songChords.add("");
          }
          else if(line.indexOf(tokenEndOfChorus) != -1){
            _songWords.add("");
            _songChords.add("");
          }
          else{
            var lineChords = StringBuffer();
            var lineWords = StringBuffer();

            for(int i = 0; i < line.length;i++){
              if(line[i] == '[') {
                startOfChord = true;
                continue;
              }
              if(line[i] == ']') {
                startOfChord = false;
                continue;
              }
              if(startOfChord){
                lineChords.write(line[i]);
              }
              else {
                lineWords.write(line[i]);
                lineChords.write(" ");
              }
            }

            _songWords.add(lineWords.toString());
            _songChords.add(lineChords.toString());
          }
        }
      }

    // Format Song
    var _song = StringBuffer();
    _song.write(_songView.title + "\n");
    _song.write(_songView.author + "\n");

    for(int i = 0;i < _songWords.length;i++){
      _song.write(_songChords[i] + "\n");
      _song.write(_songWords[i] + "\n");
    }
    _songFormatted.add(_song.toString());

    _navigateToNextScreen(context, _songView);
  }

  
  String getToken(String token, String text){
    int posEnd = 0;
    int posStart = text.indexOf(token);
    if (posStart == -1) return "";

    posEnd = text.indexOf("}", posStart + token.length);
    if(posEnd == -1) posEnd = text.indexOf("\n", posStart + token.length);
    if(posEnd == -1) posEnd = text.indexOf("\r", posStart + token.length);

    if(posEnd == -1) return text.substring(posStart + token.length).trim();
    else return text.substring(posStart + token.length, posEnd).trim();
  }

  void _onNavBarTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
