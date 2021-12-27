import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mobile_qiita_app/pages/bottom_navigation.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  bool _isLoading = false;

  // ModelSheetでログイン画面を表示
  void _showModelSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.95,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
                  color: const Color(0xF7F7F7FF),
                ),
                height: 55.0,
                child: Center(
                  child: const Text(
                    'Qiita Auth',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontFamily: 'Pacifico',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: WebView(
                    initialUrl: 'https://qiita.com/login',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 指定された秒数だけ読み込みのCupertinoActivityIndicatorを表示
  Future<void> _showActivityIndicator(int seconds) async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(Duration(seconds: seconds));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/top_page_background.jpg'),
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
                              style: TextStyle(
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
                              style: TextStyle(
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
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25.0),
                              ),
                            ),
                            onPressed: _showModelSheet,
                            child: const Text(
                              'ログイン',
                              style: TextStyle(
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigation()));
                            },
                            child: const Text(
                              'ログインせずに利用する',
                              style: TextStyle(
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
          _isLoading ? BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: _isLoading ? 3 : 0,
              sigmaY: _isLoading ? 3 : 0,
            ),
            child: Container(
              color: Color(0).withOpacity(0),
            ),
          ) : Container(),
          _isLoading ? Center(
            child: CupertinoActivityIndicator(
              radius: 20.0,
            ),
          ) : Container(),
        ],
      ),
    );
  }
}
