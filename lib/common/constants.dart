import 'package:flutter/cupertino.dart';

// 定数
class Constants {
  static const String pacifico = 'Pacifico';

  static const Color lightPrimaryBlack = Color(0xFF333333);
  static const Color lightPrimaryColor = Color(0xFF468300);
  static const Color lightSecondaryColor = Color(0xFF74C13A);
  static const Color lightSecondaryGrey = Color(0xFF828282);
  static const Color gray5 = Color(0xFFE0E0E0);
  static const Color gray6 = Color(0xFFF2F2F2);
  static const Color roundedTextButtonPrimary = Color(0xFFF9FCFF);

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
}
