import 'package:flutter/material.dart';
import 'package:uitrace20210930/top_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  final pageWidgets = [
    TopPage(),
    Center(child: Text('Notifications')),
    Center(child: Text('Search')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageWidgets.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_outlined), title: Text('Notifications')),
          BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('Search')),
        ],
        currentIndex: currentIndex,
        onTap: onItemTapped,
      ),
    );
  }
  void onItemTapped(int index) => setState(() => currentIndex = index);
}
