import 'package:mobile_qiita_app/models/user.dart';

// 各クラス共通で利用する変数を格納するためのクラス
class Variables {
  // TODO: flutter_secure_storageで保存（ログアウト機能実装時）
  static String accessToken = '';

  // TODO: shared_preferencesで保存（ログアウト機能実装時）
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
