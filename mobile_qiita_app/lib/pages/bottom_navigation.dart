import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/pages/feed_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int _selectedIndex = 0;

  // TODO: 各ページを作成するごとに更新
  final _widgetOptions = [
    FeedPage(),
    Center(child: const Text('タグ')),
    Center(child: const Text('マイページ')),
    Center(child: const Text('設定')),
  ];

  // タップされたindexの値を_selectedIndexに代入
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF74C13A),
        unselectedItemColor: const Color(0xFF828282),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}