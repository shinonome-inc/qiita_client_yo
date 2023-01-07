import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/pages/top_page.dart';
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

  Future<void> _calculateWebViewHeight() async {
    double newHeight = double.parse(
      await _webViewController
          .evaluateJavascript("document.documentElement.scrollHeight;"),
    );
    setState(() {
      _webViewHeight = newHeight;
    });
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
    double deviceKeyBordHeight = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      height: _webViewHeight + deviceKeyBordHeight,
      child: WebView(
        initialUrl: widget.initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String url) async {
          _calculateWebViewHeight();
          bool hasCode =
              url.contains('https://qiita.com/settings/applications?code');
          if (hasCode) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => TopPage(redirectUrl: url),
              ),
            );
          }
        },
        onWebViewCreated: (controller) async {
          _webViewController = controller;
        },
      ),
    );
  }
}
