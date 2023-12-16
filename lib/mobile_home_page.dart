import 'package:flutter/material.dart';
import 'package:story_flakes/connection_check_page.dart';
import 'package:story_flakes/inspiration.dart';
import 'package:story_flakes/notifications.dart';
import 'package:story_flakes/profile_page.dart';
import 'package:story_flakes/projects.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  int _selectedIndex = 1;

  static const List<Widget> _children = [
    ConnectionCheckPage(page: Inspiration(), hideAppBar: true),
    ConnectionCheckPage(page: Projects(), hideAppBar: true),
    ConnectionCheckPage(page: Notifications(), hideAppBar: true)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$_selectedIndex")),
      drawer: Drawer(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 5.0, 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()))
                        .then((value) {
                      setState(() {});
                    });
                  },
                  child: DrawerHeader(
                      child: Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50.0,
                              backgroundImage: FirebaseAuth.instance.currentUser!.photoURL == null ? null : NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                            ),
                            const SizedBox(height: 10.0),
                            FirebaseAuth.instance.currentUser!.displayName == null ? const Text("") : Text(FirebaseAuth.instance.currentUser!.displayName!, style: const TextStyle(fontSize: 16.0)),
                          ],
                        ),
                      )
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()))
                            .then((value) {
                              setState(() {});
                        });
                      },
                      title: Text("Profile"),
                    ),
                    ListTile(
                      title: const Text("Archive"),
                    ),
                    ListTile(
                      title: const Text("Subscription"),
                    ),
                    ListTile(
                      title: const Text("Settings"),
                    ),
                    ListTile(
                      title: const Text("Log Out"),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
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
