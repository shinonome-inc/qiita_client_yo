import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/views/web_view_in_modal_bottom_sheet.dart';

class ScrollableModalBottomSheet {
  static void showWebContent(
      BuildContext context, String headerTitle, String webViewUrl) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) => DraggableScrollableSheet(
        expand: false,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        initialChildSize: 0.95,
        builder: (context, scrollController) {
          return WebViewInModalBottomSheet(
            headerTitle: headerTitle,
            webViewUrl: webViewUrl,
          );
        },
      ),
    );
  }
}