//import 'package:team_player/bars/bottomNavBarHome.dart';
//import 'package:rive/rive.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:circle_list/circle_list.dart';
import 'package:team_player/pages/playlist_page.dart';
import 'package:team_player/pages/profile_page.dart';
import 'package:team_player/pages/settings_page.dart';
import 'package:team_player/pages/Songslibrary_page.dart';
import 'package:team_player/pages/song_page.dart';
import 'package:team_player/pages/sync_page.dart';
import 'package:team_player/utils/dropbox.dart';
import 'package:team_player/utils/helpers.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Map<String, Widget> myPageRoutes = {
    'images/add.png' : dropBoxTest(),
    'images/sync.png' : SyncPage(),
    'images/settings.png' : SettingsPage(),
    'images/profile2.png' : ProfilePage(),
    'images/music.png' : SongsPage(),
    'images/playlist.png' : PlaylistPage(),
  };

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Team Player'),
        centerTitle: true,
      ),
      //bottomNavigationBar: BottomNavBarHome(),
      body: Center(
        child: CircleList(
            origin: Offset(0,0),
          centerWidget: GestureDetector(
            onTap: () => exit(0),
            child: ClipRRect(
              borderRadius:BorderRadius.all(Radius.circular(100)),
              //child: RiveAnimation.asset('assets/power.riv') ,
              child: Image.asset('images/power2.png'),
              ),
            ),
            children: myPageRoutes.keys.map((item) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => myPageRoutes[item]!),
                  );
                },
                child: Image.asset(item,width: 70,height: 70),
              );
            }).toList(),
          ),
        ),
    );
  }
}
