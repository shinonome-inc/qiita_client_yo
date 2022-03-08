import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

// 定数
class Constants {
  // UIに関する定数
  static const String pacifico = 'Pacifico';
  static const Color lightPrimaryBlack = Color(0xFF333333);
  static const Color lightPrimaryColor = Color(0xFF468300);
  static const Color lightSecondaryColor = Color(0xFF74C13A);
  static const Color lightSecondaryGrey = Color(0xFF828282);
  static const Color gray6 = Color(0xFFF2F2F2);
  static const headerTextStyle = TextStyle(
    color: Color(0xFF000000),
    fontSize: 19.0,
    fontFamily: pacifico,
    fontWeight: FontWeight.bold,
  );
  static const appBarTextStyle = TextStyle(
    color: Color(0xFF000000),
    fontSize: 17.0,
    fontWeight: FontWeight.w400,
    fontFamily: pacifico,
  );
  static const String defaultUserIconUrl =
      'https://secure.gravatar.com/avatar/931b4bb04a18ab8874b2114493d0ea8e';
  static const String defaultTagIconUrl =
      'https://cdn.qiita.com/assets/icons/medium/missing-2e17009a0b32a6423572b0e6dc56727e.png';

  // 認証に関する定数
  static const String scopeOfQiitaAuthorization = 'read_qiita';
  static const String accessTokenEndPoint =
      'https://qiita.com/settings/applications?code';
  static const String accessTokenKey = 'qiitaAccessToken';

  // その他の定数
  static final postedDateFormat = DateFormat('yyyy-MM-dd');
}
