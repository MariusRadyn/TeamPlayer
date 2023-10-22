import 'package:flutter/material.dart';
import 'package:team_player/utils/helpers.dart';


class SyncPage extends StatefulWidget {
  const SyncPage({super.key});

  @override
  State<SyncPage> createState() => _SyncPageState();
}

class _SyncPageState extends State<SyncPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sync'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              height: 30,
              width: 300,
              child: Text(''),

            ),
          ),
        ],
      ) ,
    );
  }
}
