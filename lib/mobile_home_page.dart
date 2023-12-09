import 'package:flutter/material.dart';
import 'package:story_flakes/inspiration.dart';
import 'package:story_flakes/notifications.dart';
import 'package:story_flakes/projects.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  int _selectedIndex = 1;

  static const List<Widget> _children = [
    Inspiration(),
    Projects(),
    Notifications()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("$_selectedIndex"),
        actions: [
          PopupMenuButton(
            itemBuilder: (buildContext) {
                return List.empty();
              },
            icon: const Icon(Icons.menu),
          )
        ],
      ),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.lightbulb_outline), label: "Inspiration", activeIcon: Icon(Icons.lightbulb)),
          BottomNavigationBarItem(icon: Icon(Icons.file_copy_outlined), label: "Projects", activeIcon: Icon(Icons.file_copy)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), label: "Notifications", activeIcon: Icon(Icons.notifications))
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        iconSize: 25,
        onTap: _onItemTapped,
        elevation: 5,
        showUnselectedLabels: false,
      ),
    );
  }
}
