import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/components/rounded_text_button.dart';
import 'package:mobile_qiita_app/components/scrollable_modal_bottom_sheet.dart';
import 'package:mobile_qiita_app/components/web_view_component.dart';
import 'package:mobile_qiita_app/qiita_auth_key.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:mobile_qiita_app/views/bottom_navigation_view.dart';

class TopPage extends StatefulWidget {
  const TopPage({this.redirectUrl, Key? key}) : super(key: key);
  final String? redirectUrl;

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  bool _isLoading = false;

  Future<void> _loginToQiita() async {
    _isLoading = true;
    await QiitaClient.fetchAccessToken(widget.redirectUrl.toString());
    _isLoading = false;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => BottomNavigationView(),
      ),
      (_) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.redirectUrl != null) {
      _loginToQiita();
    }
  }

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
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
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
                          const SizedBox(height: 8.0),
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
                          RoundedTextButton(
                            onPressed: () {
                              String loginUrl =
                                  'https://qiita.com/api/v2/oauth/authorize?client_id=${QiitaAuthKey.clientId}&scope=read_qiita';
                              showScrollableModalBottomSheet(
                                context: context,
                                headerText: 'Qiita Auth',
                                child: WebViewComponent(url: loginUrl),
                              );
                            },
                            buttonText: 'ログイン',
                            backgroundColor: Constants.lightPrimaryColor,
                          ),
                          const SizedBox(height: 16.0),
                          RoundedTextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavigationView(),
                                ),
                              );
                            },
                            buttonText: 'ログインせずに利用する',
                            backgroundColor: Colors.transparent,
                          ),
                          const SizedBox(height: 64.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: _isLoading ? 3 : 0,
                sigmaY: _isLoading ? 3 : 0,
              ),
              child: Container(color: Color(0).withOpacity(0)),
            ),
          if (_isLoading) Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
