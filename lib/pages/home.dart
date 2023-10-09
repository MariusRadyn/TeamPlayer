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
    'images/Alarm1.jpg',
    'images/ArrowDown.png',
    'images/ArrowUp.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x313131),
      bottomNavigationBar: BottomNavBarHome(),
      body: Center(
        child: CircleList(
            origin: Offset(0,0),
            children: icons.map((imgPaths) {
              return GestureDetector(
                onTap: (){ },
                child: Image.asset(imgPaths, scale: 2,),
              );
            }).toList(),
          centerWidget: GestureDetector(
            onTap: () {},
            child: ClipRRect(
              borderRadius:BorderRadius.all(Radius.circular(100)),
              child: RiveAnimation.asset('assets/power.riv') ,
              ),
            ),
          ),
        ),
    );
  }

  void press()
  {
    print('Halo');
  }
}
