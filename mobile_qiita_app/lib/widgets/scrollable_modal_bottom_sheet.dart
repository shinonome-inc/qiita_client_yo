import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/widgets/web_view_in_modal_bottom_sheet.dart';

class ScrollableModalBottomSheet {
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
      builder: (BuildContext context) => DraggableScrollableSheet(
        expand: false,
        maxChildSize: 0.96,
        minChildSize: 0.8,
        initialChildSize: 0.96,
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
