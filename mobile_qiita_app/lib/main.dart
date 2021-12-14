import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/pages/top_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Qiita App',
      home: TopPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
