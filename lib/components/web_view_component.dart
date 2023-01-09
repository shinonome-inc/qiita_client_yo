import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_qiita_app/pages/top_page.dart';
import 'package:mobile_qiita_app/providers/web_view_height_notifier.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewComponent extends ConsumerStatefulWidget {
  const WebViewComponent({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  WebViewState createState() => WebViewState();
}

class WebViewState extends ConsumerState<WebViewComponent> {
  late WebViewController _controller;

  void onPageFinished(String url, {required WebViewController controller}) {
    final notifier = ref.read(webViewHeightProvider.notifier);
    notifier.calculateWebViewHeight(controller);
    final bool hasCode =
        url.contains('https://qiita.com/settings/applications?code');
    if (hasCode) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => TopPage(redirectUrl: url),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    final WebViewController controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) =>
              onPageFinished(url, controller: controller),
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    final double deviceKeyBordHeight = MediaQuery.of(context).viewInsets.bottom;
    final double webViewHeight = ref.watch(webViewHeightProvider);
    return SizedBox(
      height: webViewHeight + deviceKeyBordHeight,
      child: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
