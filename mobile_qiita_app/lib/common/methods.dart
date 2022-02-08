import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/widgets/web_view_screen.dart';

// 各クラス共通で利用するメソッドを格納するためのクラス
class Methods {
  // WebView用のshowModalSheetを表示
  static void showWebContent(
      BuildContext context, String headerTitle, String webViewUrl) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24.0),
        ),
      ),
      builder: (context) {
        return WebViewContent(
          headerTitle: headerTitle,
          webViewUrl: webViewUrl,
        );
      },
    );
  }
}
