import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/common/keys.dart';
import 'package:mobile_qiita_app/common/methods.dart';
import 'package:mobile_qiita_app/common/texts.dart';
import 'package:mobile_qiita_app/common/variables.dart';
import 'package:mobile_qiita_app/components/app_bar_component.dart';
import 'package:mobile_qiita_app/components/app_info_component.dart';
import 'package:mobile_qiita_app/components/setting_item_component.dart';
import 'package:mobile_qiita_app/pages/top_page.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _storage = FlutterSecureStorage();
  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _deleteUserInfoFromStorage() async {
    await _storage.delete(key: Keys.accessToken);

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Keys.userId, '');
    prefs.setString(Keys.userName, '');
    prefs.setString(Keys.userIconUrl, Constants.defaultUserIconUrl);
    prefs.setString(Keys.userDescription, '');
    prefs.setInt(Keys.userFollowingsCount, 0);
    prefs.setInt(Keys.userFollowersCount, 0);
    prefs.setInt(Keys.userPosts, 0);
  }

  Future<void> _logoutFromQiita(BuildContext context) async {
    await QiitaClient.disableAccessToken();
    await _deleteUserInfoFromStorage();
    Variables.isAuthenticated = false;

    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => TopPage(),
      ),
      (_) => false,
    );
  }

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
                style: TextStyle(color: Constants.lightSecondaryGrey),
              ),
            ),
            SettingsItemComponent(
              onTap: () {
                Methods.showScrollableModalBottomSheet(
                  context,
                  'プライバシーポリシー',
                  AppInfoComponent(text: Texts.privacyPolicyText),
                );
              },
              title: const Text('プライバシーポリシー'),
              item: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Constants.lightPrimaryBlack,
              ),
            ),
            SettingsItemComponent(
              onTap: () {
                Methods.showScrollableModalBottomSheet(
                  context,
                  '利用規約',
                  AppInfoComponent(text: Texts.termOfServiceText),
                );
              },
              title: const Text('利用規約'),
              item: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Constants.lightPrimaryBlack,
              ),
            ),
            SettingsItemComponent(
              onTap: () {},
              title: const Text('アプリバージョン'),
              item: Text(
                'v${_packageInfo.version}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            if (Variables.isAuthenticated)
              Container(
                padding:
                    const EdgeInsets.only(left: 16.0, top: 36.0, bottom: 8.0),
                child: const Text(
                  'その他',
                  style: TextStyle(color: Constants.lightSecondaryGrey),
                ),
              ),
            if (Variables.isAuthenticated)
              SettingsItemComponent(
                onTap: () {
                  _logoutFromQiita(context);
                },
                title: const Text('ログアウトする'),
                item: Container(),
              ),
          ],
        ),
      ),
    );
  }
}
