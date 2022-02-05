import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/pages/bottom_navigation.dart';

// 各クラス共通で利用するメソッドを格納するためのクラス
class Methods {
  // FeedPageへ遷移
  void transitionToFeedPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavigation(),
      ),
    );
  }
}
