import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

final webViewHeightProvider =
    StateNotifierProvider<WebViewHeightNotifier, double>(
  (ref) => WebViewHeightNotifier(),
);

class WebViewHeightNotifier extends StateNotifier<double> {
  WebViewHeightNotifier() : super(0.0);

  Future<void> calculateWebViewHeight(WebViewController controller) async {
    const String javaScript = 'document.documentElement.scrollHeight;';
    final result = await controller.runJavaScriptReturningResult(javaScript);
    final double height = double.parse(result.toString());
    state = height;
  }
}
