import 'package:flutter/material.dart';

class WidgetParts {
  // 記事一覧の上に表示する「投稿記事」のラベル
  static final Widget postedArticleLabel = Container(
    padding: const EdgeInsets.all(8.0),
    color: const Color(0xFFF2F2F2),
    alignment: Alignment.centerLeft,
    child: const Text(
      '投稿記事',
      style: TextStyle(
        color: const Color(0xFF828282),
      ),
    ),
  );
}
