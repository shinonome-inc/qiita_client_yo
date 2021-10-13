import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/pages/top_page.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => TopPage(),
  },
));