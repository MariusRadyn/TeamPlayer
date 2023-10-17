import 'package:flutter/material.dart';
import 'package:scrollable_reorderable_navbar/scrollable_reorderable_navbar.dart';
import 'package:team_player/theme/theme_constants.dart';

class BottomNavBarHome extends StatefulWidget {
  const BottomNavBarHome({super.key});

  @override
  State<BottomNavBarHome> createState() => _BottomNavBarHomeState();
}

class _BottomNavBarHomeState extends State<BottomNavBarHome> {
  int _selectedIndex = 0;
  List<NavBarItem> _items = const [
    NavBarItem(
        widget: Icon(Icons.music_note_outlined, color: COLOR_DARK_HEDDING,),
        name: "Song"),
    NavBarItem(widget: Icon(Icons.library_books, color: COLOR_DARK_HEDDING,), name: "Playlist"),
    NavBarItem(widget: Icon(Icons.edit, color: COLOR_DARK_HEDDING,), name: "Edit"),
    NavBarItem(widget: Icon(Icons.settings, color: COLOR_DARK_HEDDING,), name: "Settings"),
    NavBarItem(widget: Icon(Icons.image), name: "Pictures"),
    NavBarItem(widget: Icon(Icons.message), name: "Messages"),
  ];

  @override
  Widget build(BuildContext context) {
    return ScrollableReorderableNavBar(
      items: _items,
      onItemTap: (arg) {
        setState(() {
          _selectedIndex = arg;
        });
      },
      backgroundColor: Theme.of(context).cardColor,
      onReorder: (oldIndex, newIndex) {
        final currItem = _items[_selectedIndex];
        if (oldIndex < newIndex) newIndex -= 1;
        final newItems = [..._items], item = newItems.removeAt(oldIndex);
        newItems.insert(newIndex, item);
        setState(() {
          _items = newItems;
          _selectedIndex = _items.indexOf(currItem);
        });
      },
      selectedIndex: _selectedIndex,
      onDelete: (index) => setState(() => _items.removeAt(index)),
      deleteIndicationWidget: Container(
        padding: const EdgeInsets.only(bottom: 100),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            direction: Axis.vertical,
            children: [
              Text("Tap on nav item to delete it.",
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center),
              TextButton(onPressed: () {}, child: const Text("DONE"))
            ],
          ),
        ),
      ),
    );
  }
}
