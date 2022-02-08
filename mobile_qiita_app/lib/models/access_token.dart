import 'package:mobile_qiita_app/qiita_auth_key.dart';

class AccessToken {
  final String clientId = QiitaAuthKey.clientId;
  final String clientSecret = QiitaAuthKey.clientSecret;
  final String code;

  AccessToken({required this.code});
}
