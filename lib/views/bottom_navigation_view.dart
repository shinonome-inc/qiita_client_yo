import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/common/variables.dart';
import 'package:mobile_qiita_app/pages/feed_page.dart';
import 'package:mobile_qiita_app/pages/setting_page.dart';
import 'package:mobile_qiita_app/pages/tag_page.dart';
import 'package:mobile_qiita_app/pages/user_page.dart';
import 'package:mobile_qiita_app/views/not_login_view.dart';

class BottomNavigationView extends StatelessWidget {
  const BottomNavigationView({Key? key}) : super(key: key);

  Widget _selectDisplayPage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return FeedPage();
      case 1:
        return TagPage();
      case 2:
        return Variables.isAuthenticated
            ? UserPage(
                user: Variables.authenticatedUser,
                appBarTitle: 'MyPage',
                useBackButton: false,
              )
            : NotLoginView();
      case 3:
        return SettingPage();
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Constants.lightSecondaryColor,
        inactiveColor: Constants.lightSecondaryGrey,
        iconSize: 24.0,
        border: Border(
          top: BorderSide(
            color: const Color(0xFFC6C6C6),
            width: 1.0,
          ),
        ),
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
      tabBuilder: (BuildContext context, int index) => CupertinoTabView(
        builder: (context) => CupertinoPageScaffold(
          child: _selectDisplayPage(index),
        ),
      ),
    );
  }
}
