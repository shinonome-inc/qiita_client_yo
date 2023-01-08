import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/components/scrollable_modal_bottom_sheet.dart';
import 'package:mobile_qiita_app/components/web_view_component.dart';
import 'package:mobile_qiita_app/qiita_auth_key.dart';

// 各クラス共通で利用するメソッドを格納するためのクラス
class Methods {
  static void showScrollableModalBottomSheet(
    BuildContext context,
    String headerTitle,
    Widget child,
  ) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (context) {
        return ScrollableModalBottomSheet(
          headerTitle: headerTitle,
          statusBarHeight: statusBarHeight,
          child: child,
        );
      },
    );
  }

  static void transitionToLoginScreen(BuildContext context) {
    late String loginUrl =
        'https://qiita.com/api/v2/oauth/authorize?client_id=${QiitaAuthKey.clientId}&scope=read_qiita';
    final String appBarText = 'Qiita Auth';
    Methods.showScrollableModalBottomSheet(
      context,
      appBarText,
      WebViewComponent(initialUrl: loginUrl),
    );
  }
}
