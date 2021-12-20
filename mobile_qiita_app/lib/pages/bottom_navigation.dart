import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: const Color(0xFF74C13A),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_outlined),
            label: 'フィード',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.label_outline),
            label: 'タグ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'マイページ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: '設定',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) => CupertinoPageScaffold(child: const Text('FeedPage')),
          );
          case 1:
            return CupertinoTabView(
              builder: (context) => CupertinoPageScaffold(child: const Text('TagPage')),
          );
          case 2:
            return CupertinoTabView(
              builder: (context) => CupertinoPageScaffold(child: const Text('MyPage')),
          );
          case 3:
            return CupertinoTabView(
              builder: (context) => CupertinoPageScaffold(child: const Text('SettingPage')),
          );
          default:
            return Container();
        }
      },
    );
  }
}