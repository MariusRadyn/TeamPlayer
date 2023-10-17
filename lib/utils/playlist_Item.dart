import 'package:flutter/material.dart';

class PlayListItem extends StatelessWidget {
  final String text;
  final String subText;
  Function()? onDelete;

  PlayListItem({
    super.key,
    required this.text,
    this.subText = '',
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(2),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(5,2,0,0),
                child: Text(text,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(5,0,0,0),
                child: Text(subText,
                  style: TextStyle(color: Colors.white38),
                ),
              ),
            ],
          ),
          Expanded(
            child: IconButton(
              alignment: Alignment.centerRight,
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                  size: 30,
                )
            ),
          )
        ],
      ),
    );
  }
}
