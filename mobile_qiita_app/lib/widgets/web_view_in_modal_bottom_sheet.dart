import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewInModalBottomSheet extends StatefulWidget {
  const WebViewInModalBottomSheet({
    required this.headerTitle,
    required this.webViewUrl,
    Key? key,
  }) : super(key: key);

  final String headerTitle;
  final String webViewUrl;

  @override
  _WebViewInModalBottomSheetState createState() =>
      _WebViewInModalBottomSheetState();
}

class _WebViewInModalBottomSheetState extends State<WebViewInModalBottomSheet> {
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
                  onPageFinished: (String url) => _calculateWebViewHeight(),
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
  }
}
