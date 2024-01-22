//import 'package:team_player/bars/bottomNavBarHome.dart';
//import 'package:rive/rive.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:circle_list/circle_list.dart';
import 'package:path/path.dart';
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

    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/pearl_black_crop.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(

            child: Stack(
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
                    margin: EdgeInsets.only(
                        top: 90,
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
                    margin: EdgeInsets.only(top: 35),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top:155),
                        child: Text('Welcom Marius',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top:190,
                        ),
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
          )
          //},
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
        //),
      //),
    );
  }
}

void _butLogin(){

}