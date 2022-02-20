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
  final _storage = FlutterSecureStorage();

  // ユーザーの情報を読み取る
  Future<void> _readUserInfo() async {
    Variables.accessToken =
        await _storage.read(key: Constants.qiitaAccessTokenKey);
  }

  // ログイン済みならFeedPageを表示、未ログインならTopPageを表示
  Future<void> _initInitialPage() async {
    await _readUserInfo();
    if (Variables.accessToken != null) {
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
      home: _initialPage,
      debugShowCheckedModeBanner: false,
    );
  }
}
