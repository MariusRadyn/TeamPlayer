import 'package:team_player/bars/bottomNavBarHome.dart';
import 'package:rive/rive.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:circle_list/circle_list.dart';
import 'package:team_player/pages/PlaylistPage.dart';
import 'package:team_player/pages/ProfilePage.dart';
import 'package:team_player/pages/SettingsPage.dart';
import 'package:team_player/pages/SongsPage.dart';
import 'package:team_player/pages/SyncPage.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Map<String, Widget> icons = {
    'images/add.png' : PlaylistPage(),
    'images/sync.png' : SyncPage(),
    'images/settings.png' : SettingsPage(),
    'images/profile2.png' : ProfilePage(),
    'images/music.png' : SongsPage(),
    'images/playlist.png' : PlaylistPage(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      //backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Team Player',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
        //backgroundColor: Colors.grey[800],
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
            children: icons.keys.map((item) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => icons[item]!),
                  );
                },
                child: Image.asset(item,width: 70,height: 70),
              );
            }).toList(),
          ),
        ),
    );
  }

  void doMenu()
  {
    print('Halo');
  }
}
