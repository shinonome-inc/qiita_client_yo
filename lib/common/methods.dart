import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/app_shape.dart';
import 'package:mobile_qiita_app/components/scrollable_modal_bottom_sheet.dart';
import 'package:mobile_qiita_app/components/web_view_component.dart';
import 'package:mobile_qiita_app/qiita_auth_key.dart';

// 各クラス共通で利用するメソッドを格納するためのクラス
class Methods {
  static void showScrollableModalBottomSheet(
    BuildContext context,
    String headerText,
    Widget child,
  ) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: AppShape.modalHeaderShape,
      builder: (context) {
        return ScrollableModalBottomSheet(
          headerText: headerText,
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
