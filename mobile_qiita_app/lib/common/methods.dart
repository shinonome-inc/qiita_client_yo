import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/components/modal_bottom_sheet_component.dart';
import 'package:mobile_qiita_app/qiita_auth_key.dart';

// 各クラス共通で利用するメソッドを格納するためのクラス
class Methods {
  static void showScrollableModalBottomSheet(
      BuildContext context, String headerTitle, String webViewUrl) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24.0),
        ),
      ),
      builder: (context) {
        return ModalBottomSheetComponent(
          headerTitle: headerTitle,
          webViewUrl: webViewUrl,
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
      loginUrl,
    );
  }
}
