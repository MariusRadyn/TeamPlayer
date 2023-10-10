import 'package:flutter/material.dart';
import 'package:team_player/bars/bottomNavBarHome.dart';
import 'package:circle_list/circle_list.dart';
import 'package:rive/rive.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<String> icons = [
    'images/add.png',
    'images/sync.png',
    'images/settings.png',
    'images/profile2.png',
    'images/playlist.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x313131),
      appBar: AppBar(
        title: Text('Team Player',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
          ),
        ),
        backgroundColor: Colors.grey[800],
        centerTitle: true,
      ),
      //bottomNavigationBar: BottomNavBarHome(),
      body: Center(
        child: CircleList(
            origin: Offset(0,0),
          centerWidget: GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius:BorderRadius.all(Radius.circular(100)),
              //child: RiveAnimation.asset('assets/power.riv') ,
              child: Image.asset('images/power2.png'),
              ),
            ),
            children: icons.map((imgPaths) {
              return GestureDetector(
                onTap: (){ },
                child: Image.asset(imgPaths, width: 80,height: 80,),
              );
            }).toList(),
          ),
        ),
    );
  }

  void press()
  {
    print('Halo');
  }
}
