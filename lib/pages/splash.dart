import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
   const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
         image: DecorationImage(
         image: AssetImage("images/pearl_blue.png"),
         fit: BoxFit.cover,
        ),
       ),
    );
  }
}
