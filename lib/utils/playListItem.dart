import 'package:flutter/material.dart';

class PlayListItem extends StatelessWidget {
  final String text;
  Function()? onDelete;

  PlayListItem({
    super.key,
    required this.text,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Colors.blue[600],
          borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: IconButton(
              alignment: Alignment.centerRight,
                onPressed: onDelete,
                icon: Icon(
                  Icons.dangerous_outlined,
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
