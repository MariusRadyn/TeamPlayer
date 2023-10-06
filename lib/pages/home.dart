import 'package:flutter/material.dart';
import 'package:scrollable_reorderable_navbar/scrollable_reorderable_navbar.dart';
import 'package:team_player/bars/bottomNavBarHome.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBarHome(),
      body: SafeArea(
        child: Row(
          children : <Widget> [
            TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/page1');
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.grey[300],
              ),
              icon: Icon(Icons.sync),
              label: Text('Label'),
            ),
          ],
        ),
      ),
    );
  }

  void press()
  {
    print('Halo');
  }
}
