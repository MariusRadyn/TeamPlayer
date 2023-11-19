import 'package:flutter/material.dart';
import 'package:scrollable_reorderable_navbar/scrollable_reorderable_navbar.dart';

class BottomNavBarHome extends StatefulWidget {
  const BottomNavBarHome({super.key});

  @override
  State<BottomNavBarHome> createState() => _BottomNavBarHomeState();
}

class _BottomNavBarHomeState extends State<BottomNavBarHome> {
  int _selectedIndex = 0;
  List<NavBarItem> _items = const [
    NavBarItem(widget: Icon(Icons.home), name: "Home"),
    NavBarItem(widget: Icon(Icons.group), name: "Social"),
    NavBarItem(widget: Icon(Icons.call), name: "Calls"),
    NavBarItem(widget: Icon(Icons.image), name: "Pictures"),
    NavBarItem(widget: Icon(Icons.message), name: "Messages"),
    NavBarItem(widget: Icon(Icons.settings), name: "Settings")
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
