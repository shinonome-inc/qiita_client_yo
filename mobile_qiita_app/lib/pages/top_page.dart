import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/top_page_background.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 130.0,
                      ),
                      Container(
                        child: const Text(
                          'Qiita Feed App',
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Pacifico',
                            fontSize: 36.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        child: const Text(
                          '-PlayGround-',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      FlatButton(
                        height: 44.0,
                        color: const Color(0xFF468300),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                        onPressed: () {
                          // ・ログインボタンタップでQiita認証ページへ遷移する(Auth認証）
                          // ・認証成功後02-Feed Page画面へ遷移する
                        },
                        child: const Text(
                          'ログイン',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      FlatButton(
                        height: 44.0,
                        onPressed: () {
                          // ・認証せずに利用するボタンタップで非ログイン状態でFeed画面へ 遷移する
                        },
                        child: const Text(
                          'ログインせずに利用する',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
