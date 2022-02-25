import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/components/app_bar_component.dart';
import 'package:mobile_qiita_app/components/setting_item_component.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: const AppBarComponent(title: 'Settings', useBackButton: false),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 16.0, top: 31.5, bottom: 8.0),
              child: const Text(
                'アプリ情報',
                style: TextStyle(
                  color: Constants.lightSecondaryGrey,
                ),
              ),
            ),
            SettingsItemComponent(
              title: const Text('プライバシーポリシー'),
              item: IconButton(
                onPressed: () {
                  // TODO: プライバシーポリシーへ遷移
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Constants.lightPrimaryBlack,
                ),
              ),
            ),
            SettingsItemComponent(
              title: const Text('利用規約'),
              item: IconButton(
                onPressed: () {
                  // TODO: 利用規約へ遷移
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Constants.lightPrimaryBlack,
                ),
              ),
            ),
            SettingsItemComponent(
              title: const Text('アプリバージョン'),
              item: Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: const Text(
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
              child: const Text(
                'その他',
                style: TextStyle(
                  color: Constants.lightSecondaryGrey,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // TODO: ログアウト機能
              },
              child: SettingsItemComponent(
                title: const Text('ログアウトする'),
                item: Container(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
