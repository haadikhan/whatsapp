import 'package:app_tracker/ui_pages/home.dart';
import 'package:app_tracker/ui_pages/profile_screen.dart';

import 'package:flutter/material.dart';

class NavigationTabs extends StatefulWidget {
  final userData;

  const NavigationTabs({Key? key, this.userData}) : super(key: key);
  @override
  _NavigationTabsState createState() => _NavigationTabsState();
}

class _NavigationTabsState extends State<NavigationTabs> {
  int _selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      Home(),
      Profile(userData: widget.userData),
    ];

    return Scaffold(
        body: Container(
          child: screens.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            margin: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: BottomNavigationBar(
              unselectedLabelStyle: TextStyle(color: Colors.white),
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.blue,
              currentIndex: _selectedIndex,
              showUnselectedLabels: true,
              selectedLabelStyle: TextStyle(
                color: Colors.white30,
              ),
              onTap: onItemTapped,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.explore), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people), label: 'Profile'),
              ],
            )));
  }
}
