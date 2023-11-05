import 'package:flutter/material.dart';
import '../utils/database_manager.dart';
import '../utils/global_data.dart';
import '../utils/playlist_Item.dart';
import 'package:team_player/utils/helpers.dart';
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

  @override
  void initState() {
    dbDeleteDatabase();
    loadDummyData();
    getSongLibrary();
    super.initState();
  }

  ListTile PlayListTile(int index){
    return ListTile(
      key: Key('$index'),
      title: MyPlayListItem(
        text: _songsLibrary[index]['songName'],
        subText: _songsLibrary[index]['author'],
        onDelete: (){
          setState(() {
            _songsLibrary.removeAt(index);
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
        onTap: _onItemTapped,
      ),
      body: ReorderableListView.builder(
        onReorder: (int oldIndex, int newIndex) => reorderItems(oldIndex, newIndex),
        itemCount: _songsLibrary.length,
        itemBuilder: (BuildContext context, int index) {
          return PlayListTile(index);
        },
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
