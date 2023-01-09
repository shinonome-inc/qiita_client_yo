import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_qiita_app/models/web_view_state.dart';
import 'package:webview_flutter/webview_flutter.dart';

final webViewProvider =
    StateNotifierProvider<WebViewNotifier, WebViewState>((ref) {
  return WebViewNotifier();
});

class WebViewNotifier extends StateNotifier<WebViewState> {
  WebViewNotifier() : super(const WebViewState(viewHeight: 0));

  Future<void> calculateWebViewHeight(WebViewController controller) async {
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    final result = await controller
        .runJavaScriptReturningResult("document.documentElement.scrollHeight;");
    final double height = double.parse(result.toString());
    state = state.copyWith(
      viewHeight: height,
    );
  }
}
