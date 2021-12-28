import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mobile_qiita_app/services/article.dart';

class QiitaArticlePage extends StatefulWidget {
  const QiitaArticlePage({ required this.article, Key? key}) : super(key: key);

  final Article article;

  @override
  _QiitaArticlePageState createState() => _QiitaArticlePageState();
}

class _QiitaArticlePageState extends State<QiitaArticlePage> {
  double _webViewHeight = 1;
  late WebViewController _webViewController;

  Future<void> _onPageFinished(BuildContext context, String url) async {
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
            height: 59.0,
            child: Center(
              child: const Text(
                'Article',
                style: TextStyle(
                  fontSize: 19.0,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: _webViewHeight,
                child: WebView(
                  initialUrl: widget.article.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (String url) => _onPageFinished(context, url),
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
