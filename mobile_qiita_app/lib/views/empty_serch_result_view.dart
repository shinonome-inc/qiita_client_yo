import 'package:flutter/material.dart';

// 検索結果が0件だった場合に表示
class EmptySearchResultView extends StatelessWidget {
  const EmptySearchResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '検索にマッチする記事はありませんでした',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20.0),
            const Text(
              '検索条件を変えるなどして再度検索をしてください',
              style: TextStyle(color: const Color(0xFF828282)),
            ),
          ],
        ),
      ),
    );
  }
}
