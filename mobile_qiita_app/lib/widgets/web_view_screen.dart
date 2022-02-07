import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/common/methods.dart';
import 'package:mobile_qiita_app/common/variables.dart';
import 'package:mobile_qiita_app/pages/bottom_navigation.dart';
import 'package:webview_flutter/webview_flutter.dart';

// showModalBottomSheet内で表示するWebViewのコンテンツ
class WebViewContent extends StatefulWidget {
  const WebViewContent({
    required this.headerTitle,
    required this.webViewUrl,
    Key? key,
  }) : super(key: key);

  final String headerTitle;
  final String webViewUrl;

  @override
  _WebViewContentState createState() => _WebViewContentState();
}

class _WebViewContentState extends State<WebViewContent> {
  double _webViewHeight = 0;
  late WebViewController _webViewController;

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

  // アクセス許可後に表示されるリダイレクト先のURLからアクセストークンを取得
  void _clipAccessToken(String redirectUrl) {
    int firstIndex = Constants.accessTokenEndPoint.length + 1;
    int lastIndex = redirectUrl.length;
    Variables.accessToken = redirectUrl.substring(firstIndex, lastIndex);
    print(Variables.accessToken);
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
    if (Variables.accessToken.isNotEmpty) {
      Methods.transitionToTheSpecifiedPage(context, BottomNavigation());
    }
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 0.96,
      minChildSize: 0.8,
      initialChildSize: 0.96,
      builder: (context, scrollController) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.96,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24.0),
                  ),
                  color: const Color(0xF7F7F7FF),
                ),
                height: 56.0,
                child: Center(
                  child: Text(
                    widget.headerTitle,
                    style: Constants.headerTextStyle,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: _webViewHeight,
                    child: WebView(
                      initialUrl: widget.webViewUrl,
                      javascriptMode: JavascriptMode.unrestricted,
                      onPageFinished: (String url) {
                        _calculateWebViewHeight();
                        if (url.contains(Constants.accessTokenEndPoint)) {
                          _clipAccessToken(url);
                        }
                      },
                      onWebViewCreated: (controller) async {
                        _webViewController = controller;
                      },
                      onWebResourceError: (error) {
                        print(error);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
