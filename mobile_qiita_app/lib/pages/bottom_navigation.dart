import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/variables.dart';
import 'package:mobile_qiita_app/pages/feed_page.dart';
import 'package:mobile_qiita_app/pages/follows_followers_list_page.dart';
import 'package:mobile_qiita_app/pages/tag_page.dart';
import 'package:mobile_qiita_app/pages/user_page.dart';

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
              builder: (context) => CupertinoPageScaffold(child: FeedPage()),
            );
          case 1:
            return CupertinoTabView(
              builder: (context) => CupertinoPageScaffold(child: TagPage()),
            );
          case 2:
            return CupertinoTabView(
              builder: (context) => CupertinoPageScaffold(
                child: UserPage(
                  user: Variables.authenticatedUser,
                  appBarTitle: 'MyPage',
                ),
              ),
            );
          case 3:
            return CupertinoTabView(
              builder: (context) => CupertinoPageScaffold(
                child: FollowsFollowersListPage(
                  usersType: 'Followers',
                  userId: 'Qiita',
                ),
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}
