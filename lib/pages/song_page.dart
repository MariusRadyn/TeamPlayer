import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:team_player/views/song_view.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               Container(
                 height: MediaQuery.of(context).size.height-100,
                 child: PageView(
                   controller: _controller,
                   scrollDirection: Axis.horizontal,
                   children: [
                     SongContainer(text: 'Song 1'),
                     SongContainer(text: 'Song 2'),
                   ],
                 ),
               ),
            const SizedBox(height: 25),

            SmoothPageIndicator(
                controller: _controller,
                count: 2)
            ],
          ),
        ),
     ),
    );
  }
}

