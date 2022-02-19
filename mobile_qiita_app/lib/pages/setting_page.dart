import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/common/methods.dart';
import 'package:mobile_qiita_app/components/setting_item_component.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);
  final String _webViewUrl = '';

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
            SettingsItemComponent(
              title: 'プライバシーポリシー',
              item: IconButton(
                onPressed: () {
                  Methods.showWebContent(context, 'プライバシーポリシー', _webViewUrl);
                },
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: const Color(0xFF333333),
                ),
              ),
            ),
            SettingsItemComponent(
              title: '利用規約',
              item: IconButton(
                onPressed: () {
                  Methods.showWebContent(context, '利用規約', _webViewUrl);
                },
                icon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: const Color(0xFF333333),
                ),
              ),
            ),
            SettingsItemComponent(
              title: 'アプリバージョン',
              item: Container(
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
              child: SettingsItemComponent(
                title: 'ログアウトする',
                item: Container(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
