import 'package:flutter/material.dart';
import '../utils/database_manager.dart';
import '../utils/global_data.dart';
import '../utils/playlist_Item.dart';

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

  ListTile PlayListTile(int index){
    return ListTile(
      key: Key('$index'),
      title: MyPlayListItem(
        text: _songList[index]['songName'],
        subText: _songList[index]['author'],
        onDelete: (){
          setState(() {
            _songList.removeAt(index);
          });
        },
      ),
    );
  }
  // Database
  List<Map<String, dynamic>> _songList = [];
  bool _isLoading = true;
  void _getPlayList() async {
    final data = await SQLHelper.readTable(DB_LOCAL_SONGS_TABLE);
    setState(() {
      _songList = data;
      _isLoading = false;
    });
    print(_songList);
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
      body: Column(
        children: [
          Container(
            height: 50,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
