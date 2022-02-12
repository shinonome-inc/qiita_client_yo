import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_qiita_app/common/variables.dart';
import 'package:mobile_qiita_app/models/access_token.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/models/tag.dart';
import 'package:mobile_qiita_app/models/user.dart';
import 'package:mobile_qiita_app/qiita_auth_key.dart';

class QiitaClient {
  static final authorizationRequestHeader = {
    'Authorization': 'Bearer ${Variables.accessToken}'
  };

  // アクセストークン発行
  static Future<void> fetchAccessToken(String redirectUrl) async {
    const String url = 'https://qiita.com/api/v2/access_tokens';
    final redirectUri = Uri.parse(redirectUrl);
    final queryParameters = redirectUri.queryParameters;
    final redirectUrlCode = queryParameters['code'];

    var response = await http.post(
      Uri.parse(url),
      headers: {'content-type': 'application/json'},
      body: json.encode({
        'client_id': QiitaAuthKey.clientId,
        'client_secret': QiitaAuthKey.clientSecret,
        'code': redirectUrlCode,
      }),
    );

    if (response.statusCode == 201) {
      final dynamic jsonResponse = json.decode(response.body);
      final AccessToken accessToken = AccessToken.fromJson(jsonResponse);
      Variables.accessToken = accessToken.token;
      fetchUser();
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  // QiitaAPIで記事を取得
  static Future<List<Article>> fetchArticle(int currentPageNumber,
      String searchWord, String tagId, String userId) async {
    var url;
    if (searchWord.isNotEmpty) {
      url =
          'https://qiita.com/api/v2/items?page=$currentPageNumber&query=$searchWord';
    } else if (tagId.isNotEmpty) {
      url =
          'https://qiita.com/api/v2/tags/$tagId/items?page=$currentPageNumber';
    } else if (userId.isNotEmpty) {
      url =
          'https://qiita.com/api/v2/users/$userId/items?page=$currentPageNumber';
    } else {
      url = 'https://qiita.com/api/v2/items?page=$currentPageNumber';
    }

    var response = Variables.accessToken.isNotEmpty
        ? await http.get(Uri.parse(url), headers: authorizationRequestHeader)
        : await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  // QiitaAPIでタグを取得
  static Future<List<Tag>> fetchTag(int currentPageNumber) async {
    var url =
        'https://qiita.com/api/v2/tags?page=$currentPageNumber&sort=count';

    var response = Variables.accessToken.isNotEmpty
        ? await http.get(Uri.parse(url), headers: authorizationRequestHeader)
        : await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => Tag.fromJson(json)).toList();
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  // QiitaAPIで認証中ユーザーの情報を取得
  static Future<User> fetchUser() async {
    var url = 'https://qiita.com/api/v2/authenticated_user';
    var response =
        await http.get(Uri.parse(url), headers: authorizationRequestHeader);

    if (response.statusCode == 200) {
      final dynamic jsonResponse = json.decode(response.body);
      Variables.userId = User.fromJson(jsonResponse).id;
      return User.fromJson(jsonResponse);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}
