import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_qiita_app/common/keys.dart';
import 'package:mobile_qiita_app/common/variables.dart';
import 'package:mobile_qiita_app/models/user.dart';
import 'package:mobile_qiita_app/pages/top_page.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:mobile_qiita_app/views/bottom_navigation_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _initialPage = Scaffold();

  Future<void> _checkUserInfoFromStorage() async {
    final storage = FlutterSecureStorage();
    String? accessToken = await storage.read(key: Keys.accessToken);
    if (accessToken != null) {
      Variables.isAuthenticated = true;
      QiitaClient.authorizationRequestHeader = {
        'Authorization': 'Bearer $accessToken'
      };
      await _initUserInfoFromStorage();
    }
  }

  Future<void> _initUserInfoFromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Variables.authenticatedUser = User(
      id: prefs.getString(Keys.userId) ?? '',
      name: prefs.getString(Keys.userName) ?? '',
      iconUrl: prefs.getString(Keys.userIconUrl) ?? '',
      description: prefs.getString(Keys.userDescription) ?? '',
      followingsCount: prefs.getInt(Keys.userFollowingsCount) ?? 0,
      followersCount: prefs.getInt(Keys.userFollowersCount) ?? 0,
      posts: prefs.getInt(Keys.userPosts) ?? 0,
    );
  }

  // ログイン済みならFeedPageを表示、未ログインならTopPageを表示
  Future<void> _initInitialPage() async {
    await _checkUserInfoFromStorage();
    if (Variables.isAuthenticated) {
      setState(() {
        _initialPage = BottomNavigationView();
      });
    } else {
      setState(() {
        _initialPage = TopPage();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initInitialPage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qiita Client Yo',
      debugShowCheckedModeBanner: false,
      home: _initialPage,
    );
  }
}
