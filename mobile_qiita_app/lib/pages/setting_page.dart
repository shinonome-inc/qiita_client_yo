import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/widgets/setting_item.dart';
import 'package:mobile_qiita_app/widgets/setting_item_container.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFAFAFAFF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 1.6,
        title: const Text(
          'Settings',
          style: Constants.headerTextStyle,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text('アプリ情報'),
            ),
            SettingItem(
              settingTitle: 'プライバシーポリシー',
              settingItem: IconButton(
                onPressed: () {
                  // TODO: プライバシーポリシーへ遷移
                },
                icon: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
            SettingItem(
              settingTitle: '利用規約',
              settingItem: IconButton(
                onPressed: () {
                  // TODO: 利用規約へ遷移
                },
                icon: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ),
            SettingItem(
              settingTitle: 'アプリバージョン',
              settingItem: Container(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text('1.0.0'),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Text('その他'),
            ),
            GestureDetector(
              onTap: () {
                // TODO: ログアウト機能
              },
              child: SettingItemContainer(
                child: Container(
                  height: 48,
                  alignment: Alignment.centerLeft,
                  child: Text('ログアウトする'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
