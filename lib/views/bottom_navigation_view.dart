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

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Constants.lightSecondaryColor,
        inactiveColor: Constants.lightSecondaryGrey,
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
      tabBuilder: (BuildContext context, int index) {
        Widget child;
        switch (index) {
          case 0:
            child = FeedPage();
            break;
          case 1:
            child = TagPage();
            break;
          case 2:
            child = Variables.isAuthenticated
                ? UserPage(
                    user: Variables.authenticatedUser,
                    appBarTitle: 'MyPage',
                    useBackButton: false,
                  )
                : NotLoginView();
            break;
          case 3:
            child = SettingPage();
            break;
          default:
            child = SizedBox.shrink();
        }
        return CupertinoTabView(
          builder: (context) => CupertinoPageScaffold(child: child),
        );
      },
    );
  }
}
