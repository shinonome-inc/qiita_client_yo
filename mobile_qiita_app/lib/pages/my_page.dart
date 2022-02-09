import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          QiitaClient.fetchAuthenticatedUser();
        },
      ),
    );
  }
}
