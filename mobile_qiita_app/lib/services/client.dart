import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/models/tag.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Client {
  // QiitaAPIで記事を取得
  static Future<List<Article>> fetchArticle(int currentPageNumber, String searchWord) async {
    var url = searchWord.isEmpty
        ? 'https://qiita.com/api/v2/items?page=$currentPageNumber'
        : 'https://qiita.com/api/v2/items??page=$currentPageNumber&query=$searchWord';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  // QiitaAPIでタグを取得
  static Future<List<Tag>> fetchTag(int currentPageNumber) async {
    var url = 'https://qiita.com/api/v2/tags?page=$currentPageNumber&sort=count';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => Tag.fromJson(json)).toList();
    }
    else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}