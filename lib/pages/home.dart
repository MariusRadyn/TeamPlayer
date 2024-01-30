//import 'package:team_player/bars/bottomNavBarHome.dart';
//import 'package:rive/rive.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:circle_list/circle_list.dart';
import 'package:path/path.dart';
import 'package:team_player/pages/playlist_page.dart';
import 'package:team_player/pages/profile_page.dart';
import 'package:team_player/pages/settings_page.dart';
import 'package:team_player/pages/library_page.dart';
import 'package:team_player/pages/sync_page.dart';
import 'package:team_player/pages/splash.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final Map<String, Widget> myPageRoutes = {
    'images/add.png' : LibraryPage(),
    'images/sync.png' : SyncPage(),
    'images/settings.png' : SettingsPage(),
    'images/profile2.png' : ProfilePage(),
    'images/music.png' : LibraryPage(),
    'images/playlist.png' : PlaylistPage(),
  };

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/pearl_black_crop.png"),
          fit: BoxFit.cover,
          ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            child: Column(
              children: [

               // Login Profile
                Stack(
                  children: [

                    // Backdrop
                    Container(
                      alignment: Alignment.topCenter,
                      height: 200,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [
                            0.3,
                            0.9,
                          ],
                          colors: [
                            Colors.teal,
                            Colors.black26,
                          ]
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                      ),
                    ),

                    // White Container
                    Container(
                      margin: const EdgeInsets.only(
                          top: 60,
                          left: 10,
                          right: 10
                      ),
                      height: 150,
                      decoration: const BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),

                    // Avatar
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundImage: AssetImage("images/author1.jpg") ,
                              radius: 50,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Settings Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: ()=> {
                            Navigator.push(context,
                              MaterialPageRoute(
                                builder: (context) => SettingsPage(),
                              ),
                            ),
                          },
                          child: Container(
                              child: Icon(Icons.settings)
                          ),
                        ),
                      ],
                    ),

                    // Welcome Message
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top:130),
                          child: Text('Welcome Marius',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),

                    // Login Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top:160),
                          width: 120,
                          height: 40,
                          decoration: const BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: TextButton(
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: (){
                              _butLogin();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 90),

                // Tiles
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // Library
                    GestureDetector(
                      onTap: ()=>{
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LibraryPage())
                        ),
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        width: 150,
                        height: 150,
                        decoration: tileDecoration(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/music.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Text('Library',
                                style: TextStyle(
                                  fontFamily: 'GrapeNuts',
                                  fontSize: 40,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    // Playlist
                    GestureDetector(
                      onTap: ()=>{
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PlaylistPage())
                        ),
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        width: 150,
                        height: 150,
                        decoration: tileDecoration(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/playlist.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Text('Playlist',
                                style: TextStyle(
                                  fontFamily: 'GrapeNuts',
                                  fontSize: 40,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // Sync
                    GestureDetector(
                      onTap: ()=>{
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LibraryPage())
                        ),
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        width: 150,
                        height: 150,
                        decoration: tileDecoration(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/sync.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 2),
                              child: Text('Sync',
                                style: TextStyle(
                                  fontFamily: 'GrapeNuts',
                                  fontSize: 40,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    // Team
                    GestureDetector(
                      onTap: ()=>{
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LibraryPage())
                        ),
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        width: 150,
                        height: 150,
                        decoration: tileDecoration(),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("images/profile.png"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Text('Team',
                                style: TextStyle(
                                  fontFamily: 'GrapeNuts',
                                  fontSize: 40,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}

BoxDecoration tileDecoration() {
  return BoxDecoration(
    gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [
          0.1,
          0.8,
          0.9
        ],
        colors: [
          Colors.white,
          Colors.white38,
          Colors.white
        ]
    ),
    borderRadius: const BorderRadius.all(
        Radius.circular(20)
    ),
    border: Border.all(
      color: Colors.white,
      width: 5,
    ),
    boxShadow:[
      BoxShadow(
        color: Colors.teal.withOpacity(0.5), //color of shadow
        spreadRadius: 5, //spread radius
        blurRadius: 20, // blur radius
        offset: Offset(0, 2), // changes position of shadow
        //first paramerter of offset is left-right
        //second parameter is top to down
      ),
      //you can set more BoxShadow() here
    ],
  );
}

void _butLogin(){

}