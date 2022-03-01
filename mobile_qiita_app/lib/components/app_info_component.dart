import 'package:flutter/material.dart';

// プライバシーポリシーと利用規約の文字列を受け取り表示
class AppInfoComponent extends StatelessWidget {
  const AppInfoComponent({required this.text, Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
      child: Text(text),
    );
  }
}
