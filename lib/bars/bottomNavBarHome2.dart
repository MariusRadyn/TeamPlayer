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
    return Stack(
      children: <Widget>[
        Positioned(
          left: 0,
          bottom: 0,
          width: MediaQuery.of(context).size.width / 5,
          height: kBottomNavigationBarHeight + MediaQuery.of(context).viewPadding.bottom,
          child: Container(
            decoration: decoration ?? BoxDecoration(
              color: Colors.white,
              boxShadow: const [ BoxShadow(
                color: Colors.black12, offset: Offset(0, -1), blurRadius: 0,spreadRadius: 0,)
              ],
            ),child: centerWidget ?? SizedBox(),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 5,
          bottom: 0,
          width: MediaQuery.of(context).size.width * 4 / 5,
          height: kBottomNavigationBarHeight + MediaQuery.of(context).viewPadding.bottom,
          child: Container(
            decoration: decoration ?? BoxDecoration(
              color: Colors.white,
              boxShadow: const [ BoxShadow(
                color: Colors.black12, offset: Offset(0, -1), blurRadius: 0,spreadRadius: 0,)
              ],
            ),
            child: _ScrollableReorderableNavBar(
              selectedIndex: selectedIndex,
              items: items,
              backgroundColor: backgroundColor,
              onItemTap: onItemTap,
              animationDuration: duration,
              onReorder: onReorder,
              proxyDecorator: proxyDecorator,
              onDelete: onDelete,
              deleteIndicationWidget: deleteIndicationWidget,
            ),
          ),
        ),
      ],
    );
  }