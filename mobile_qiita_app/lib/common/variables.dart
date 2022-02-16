import 'package:mobile_qiita_app/models/user.dart';

// 各クラス共通で利用する変数を格納するためのクラス
class Variables {
  static String accessToken = '';
  static User authenticatedUser = User(
    id: '',
    name: '',
    iconUrl: '',
    description: '',
    followingsCount: 0,
    followersCount: 0,
    posts: 0,
  );
}
