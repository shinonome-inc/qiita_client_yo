import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_qiita_app/pages/top_page.dart';
import 'package:mobile_qiita_app/providers/web_view_notifier.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewComponent extends ConsumerStatefulWidget {
  const WebViewComponent({Key? key, required this.initialUrl})
      : super(key: key);
  final String initialUrl;

  @override
  WebViewState createState() => WebViewState();
}

class WebViewState extends ConsumerState<WebViewComponent> {
  late WebViewController _webViewController;

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
    final state = ref.watch(webViewProvider);
    final notifier = ref.read(webViewProvider.notifier);
    return Container(
      height: state.viewHeight + deviceKeyBordHeight,
      child: WebView(
        initialUrl: widget.initialUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onPageFinished: (String url) async {
          notifier.calculateWebViewHeight(_webViewController);
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
