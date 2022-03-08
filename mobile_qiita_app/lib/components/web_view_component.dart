import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/common/variables.dart';
import 'package:mobile_qiita_app/pages/bottom_navigation.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewComponent extends StatefulWidget {
  const WebViewComponent({required this.initialUrl, Key? key})
      : super(key: key);

  final String initialUrl;

  @override
  _WebViewComponentState createState() => _WebViewComponentState();
}

class _WebViewComponentState extends State<WebViewComponent> {
  late WebViewController _webViewController;
  double _webViewHeight = 0;

  // WebViewの高さを求めて_webViewHeightに代入
  Future<void> _calculateWebViewHeight() async {
    double newHeight = double.parse(
      await _webViewController
          .evaluateJavascript("document.documentElement.scrollHeight;"),
    );
    setState(() {
      _webViewHeight = newHeight;
    });
  }

  // Qiitaにログイン（oAuth認証）
  Future<void> _loginToQiita(String redirectUrl) async {
    await QiitaClient.fetchAccessToken(redirectUrl);
    if (Variables.isAuthenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigation(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _webViewHeight,
      child: WebView(
        initialUrl: widget.initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String url) async {
          _calculateWebViewHeight();
          bool _isLogin = url.contains(Constants.accessTokenEndPoint);
          if (_isLogin) {
            await _loginToQiita(url);
          }
        },
        onWebViewCreated: (controller) async {
          _webViewController = controller;
        },
      ),
    );
  }
}
