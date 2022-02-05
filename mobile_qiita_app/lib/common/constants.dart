import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

// 各クラス共通で利用する定数を格納するためのクラス
class Constants {
  static const String pacifico = 'Pacifico';
  static const headerTextStyle = TextStyle(
    color: Color(0xFF000000),
    fontSize: 19.0,
    fontFamily: pacifico,
    fontWeight: FontWeight.bold,
  );
  static const String defaultUserIconUrl =
      'https://secure.gravatar.com/avatar/931b4bb04a18ab8874b2114493d0ea8e';
  static const String defaultTagIconUrl =
      'https://cdn.qiita.com/assets/icons/medium/missing-2e17009a0b32a6423572b0e6dc56727e.png';

  static final postedDateFormat = DateFormat('yyyy-MM-dd');

  static const String scopeOfQiitaAuthorization = 'qiita_read';
  static const String accessTokenEndPoint =
      'https://qiita.com/settings/applications?code';
}