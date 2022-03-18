import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_qiita_app/common/keys.dart';
import 'package:mobile_qiita_app/common/variables.dart';
import 'package:mobile_qiita_app/models/access_token.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/models/tag.dart';
import 'package:mobile_qiita_app/models/user.dart';
import 'package:mobile_qiita_app/qiita_auth_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QiitaClient {
  static final _storage = FlutterSecureStorage();
  static late Map<String, String> _authorizationRequestHeader;

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

      _storage.write(key: Keys.accessToken, value: accessToken.token);
      _authorizationRequestHeader = {
        'Authorization': 'Bearer ${accessToken.token}'
      };
      await fetchAuthenticatedUser();
      Variables.isAuthenticated = true;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  // アクセストークンを失効させる
  static Future<void> disableAccessToken() async {
    String? accessToken = await _storage.read(key: Keys.accessToken);
    var url = 'https://qiita.com/api/v2/access_tokens/$accessToken';
    var response = await http.delete(Uri.parse(url));

    if (response.statusCode == 204) {
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  // QiitaAPIで記事を取得
  static Future<List<Article>> fetchArticles(
      int page, String query, String tagId, String userId) async {
    var url;
    if (query.isNotEmpty) {
      url = 'https://qiita.com/api/v2/items?page=$page&query=$query';
    } else if (tagId.isNotEmpty) {
      url = 'https://qiita.com/api/v2/tags/$tagId/items?page=$page';
    } else if (userId.isNotEmpty) {
      url = 'https://qiita.com/api/v2/users/$userId/items?page=$page';
    } else {
      url = 'https://qiita.com/api/v2/items?page=$page';
    }

    var response = Variables.isAuthenticated
        ? await http.get(Uri.parse(url), headers: _authorizationRequestHeader)
        : await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  // QiitaAPIでタグを取得
  static Future<List<Tag>> fetchTags(int page) async {
    var url = 'https://qiita.com/api/v2/tags?page=$page&sort=count';

    var response = Variables.isAuthenticated
        ? await http.get(Uri.parse(url), headers: _authorizationRequestHeader)
        : await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => Tag.fromJson(json)).toList();
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  // QiitaAPIで認証中ユーザーの情報を取得
  static Future<void> fetchAuthenticatedUser() async {
    final url = 'https://qiita.com/api/v2/authenticated_user';
    var response =
        await http.get(Uri.parse(url), headers: _authorizationRequestHeader);

    if (response.statusCode == 200) {
      final dynamic jsonResponse = json.decode(response.body);
      User user = User.fromJson(jsonResponse);
      Variables.authenticatedUser = user;

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(Keys.userId, user.id);
      prefs.setString(Keys.userName, user.name);
      prefs.setString(Keys.userIconUrl, user.iconUrl);
      prefs.setString(Keys.userDescription, user.description);
      prefs.setInt(Keys.userFollowingsCount, user.followingsCount);
      prefs.setInt(Keys.userFollowersCount, user.followersCount);
      prefs.setInt(Keys.userPosts, user.posts);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  // QiitaAPIでユーザー一覧を取得
  static Future<List<User>> fetchUsers(
      int page, String usersType, String userId) async {
    var url = usersType == 'Follows'
        ? 'https://qiita.com/api/v2/users/$userId/followees?page=$page'
        : 'https://qiita.com/api/v2/users/$userId/followers?page=$page';

    var response = Variables.isAuthenticated
        ? await http.get(Uri.parse(url), headers: _authorizationRequestHeader)
        : await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  static Future<User> fetchUser(String userId) async {
    final url = 'https://qiita.com/api/v2/users/$userId';

    var response = Variables.isAuthenticated
        ? await http.get(Uri.parse(url), headers: _authorizationRequestHeader)
        : await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final dynamic jsonResponse = json.decode(response.body);
      return User.fromJson(jsonResponse);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}
