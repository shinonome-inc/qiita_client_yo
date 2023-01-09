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
    final WebViewController controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            final notifier = ref.read(webViewProvider.notifier);
            notifier.calculateWebViewHeight(controller);
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
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
    _webViewController = controller;
  }

  @override
  Widget build(BuildContext context) {
    double deviceKeyBordHeight = MediaQuery.of(context).viewInsets.bottom;
    final state = ref.watch(webViewProvider);
    return Container(
      height: state.viewHeight + deviceKeyBordHeight,
      child: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}
