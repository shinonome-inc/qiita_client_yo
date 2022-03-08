import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/common/variables.dart';
import 'package:mobile_qiita_app/pages/bottom_navigation.dart';
import 'package:mobile_qiita_app/pages/top_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _initialPage = Scaffold();

  // ユーザーの情報を読み取る
  Future<void> _readUserInfo() async {
    final storage = FlutterSecureStorage();
    String? accessToken = await storage.read(key: Constants.accessTokenKey);

    if (accessToken != null) {
      Variables.isAuthenticated = true;
    }
  }

  // ログイン済みならFeedPageを表示、未ログインならTopPageを表示
  Future<void> _initInitialPage() async {
    await _readUserInfo();
    if (Variables.isAuthenticated) {
      setState(() {
        _initialPage = BottomNavigation();
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
      title: 'Mobile Qiita App',
      debugShowCheckedModeBanner: false,
      home: _initialPage,
    );
  }
}
