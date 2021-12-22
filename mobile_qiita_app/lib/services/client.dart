import 'package:mobile_qiita_app/services/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Client {
  // QiitaAPIで記事を取得
  static Future<List<Article>> fetchArticle(int pageNumber, String searchWord) async {
    var url;
    if (searchWord == '') {
      url = 'https://qiita.com/api/v2/items?page=${pageNumber}';
    }
    else {
      url = 'https://qiita.com/api/v2/items?page=${pageNumber}&query=${searchWord}';
    }
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((json) => Article.fromJson(json)).toList();
    }
    else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}