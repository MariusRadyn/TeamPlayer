//import 'package:team_player/bars/bottomNavBarHome.dart';
//import 'package:rive/rive.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:circle_list/circle_list.dart';
import 'package:team_player/pages/playlist_page.dart';
import 'package:team_player/pages/profile_page.dart';
import 'package:team_player/pages/settings_page.dart';
import 'package:team_player/pages/Songslibrary_page.dart';
import 'package:team_player/pages/sync_page.dart';
import 'package:team_player/pages/splash.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Map<String, Widget> myPageRoutes = {
    'images/add.png' : SongsPage(),
    'images/sync.png' : SyncPage(),
    'images/settings.png' : SettingsPage(),
    'images/profile2.png' : ProfilePage(),
    'images/music.png' : SongsPage(),
    'images/playlist.png' : PlaylistPage(),
  };

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //backgroundColor: Colors.white,
      //bottomNavigationBar: BottomNavBarHome(),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                   image: DecorationImage(
                    image: AssetImage("images/pearl_black_crop.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          height: 80,
                          color: Colors.blueGrey,
                          child: Center(
                            child: CircleAvatar(
                              backgroundImage: AssetImage("images/author1.jpg") ,
                              radius: 50,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                // child: Center(
                //   child: CircleList(
                //       origin: Offset(0,0),
                //     centerWidget: GestureDetector(
                //       onTap: () => exit(0),
                //       child: ClipRRect(
                //         borderRadius:BorderRadius.all(Radius.circular(10)),
                //         child: Image.asset('images/power2.png'),
                //         ),
                //       ),
                //       children: myPageRoutes.keys.map((item) {
                //         return GestureDetector(
                //           onTap: () {
                //             Navigator.push(context,
                //               MaterialPageRoute(builder: (context) => myPageRoutes[item]!),
                //             );
                //           },
                //           child: Image.asset(item,width: 50,height: 50),
                //         );
                //       }).toList(),
                //     ),
                //   ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
