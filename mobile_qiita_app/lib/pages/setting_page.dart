import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/widgets/setting_item.dart';
import 'package:mobile_qiita_app/widgets/setting_item_container.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
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
              margin: const EdgeInsets.only(left: 16.0, top: 31.5, bottom: 8.0),
              child: Text(
                'アプリ情報',
                style: TextStyle(
                  color: const Color(0xFF828282),
                ),
              ),
            ),
            SettingItem(
              settingTitle: 'プライバシーポリシー',
              settingItem: IconButton(
                onPressed: () {
                  // TODO: プライバシーポリシーへ遷移
                },
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: const Color(0xFF333333),
                ),
              ),
            ),
            SettingItem(
              settingTitle: '利用規約',
              settingItem: IconButton(
                onPressed: () {
                  // TODO: 利用規約へ遷移
                },
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: const Color(0xFF333333),
                ),
              ),
            ),
            SettingItem(
              settingTitle: 'アプリバージョン',
              settingItem: Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: Text(
                  'v1.0.0',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 36.0, bottom: 8.0),
              child: Text(
                'その他',
                style: TextStyle(
                  color: const Color(0xFF828282),
                ),
              ),
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
