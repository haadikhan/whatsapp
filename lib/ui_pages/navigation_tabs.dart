import 'package:app_tracker/ui_pages/home.dart';
import 'package:app_tracker/ui_pages/profile_screen.dart';

import 'package:app_tracker/ui_pages/usage_history.dart';
import 'package:flutter/material.dart';

class NavigationTabs extends StatefulWidget {
  @override
  _NavigationTabsState createState() => _NavigationTabsState();
}

class _NavigationTabsState extends State<NavigationTabs> {
  int _selectedIndex = 0;
  List<Widget> screens = [
    Home(),
    Profile(),
    UsageHistory(),
  ];
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                BottomNavigationBarItem(
                    icon: Icon(Icons.history), label: 'History'),
              ],
            )));
  }
}
