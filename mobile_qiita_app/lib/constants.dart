import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class Constants {
  static const String pacifico = 'Pacifico';
  static const headerTextStyle = TextStyle(
    fontSize: 19.0,
    fontFamily: pacifico,
    fontWeight: FontWeight.bold,
  );
  static const String defaultUserIconUrl =
      'https://secure.gravatar.com/avatar/931b4bb04a18ab8874b2114493d0ea8e';
  static final postedDateFormat = DateFormat('yyyy-MM-dd');
}
