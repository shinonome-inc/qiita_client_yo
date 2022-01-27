import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/constants.dart';
import 'package:mobile_qiita_app/pages/bottom_navigation.dart';
import 'package:mobile_qiita_app/qiita_auth_key.dart';
import 'package:mobile_qiita_app/widgets/scrollable_modal_bottom_sheet.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  bool _isLoading = false;
  late String loginUrl =
      'https://qiita.com/api/v2/oauth/authorize?client_id=${QiitaAuthKey.clientId}&scope=${Constants.scopeOfQiitaAuthorization}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    const AssetImage('assets/images/top_page_background.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 144.0,
                          ),
                          Container(
                            child: const Text(
                              'Qiita Feed App',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: Constants.pacifico,
                                fontSize: 36.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
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
                            height: 48.0,
                            color: const Color(0xFF468300),
                            shape: RoundedRectangleBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(24.0),
                              ),
                            ),
                            onPressed: () {
                              ScrollableModalBottomSheet.showWebContent(
                                context,
                                'Qiita Auth',
                                loginUrl,
                              );
                            },
                            child: const Text(
                              'ログイン',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          FlatButton(
                            height: 48.0,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavigation(),
                                ),
                              );
                            },
                            child: const Text(
                              'ログインせずに利用する',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 32.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _isLoading
              ? BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: _isLoading ? 3 : 0,
                    sigmaY: _isLoading ? 3 : 0,
                  ),
                  child: Container(
                    color: Color(0).withOpacity(0),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
