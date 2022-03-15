import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';

// FeedPageで検索結果が0件だった場合に表示
class EmptySearchResultView extends StatelessWidget {
  const EmptySearchResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('検索にマッチする記事はありませんでした'),
            const SizedBox(height: 20.0),
            const Text(
              '検索条件を変えるなどして再度検索をしてください',
              style: TextStyle(
                color: Constants.lightSecondaryGrey,
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 78.0), // 画面比率の調整
          ],
        ),
      ),
    );
  }
}
