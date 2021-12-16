import 'package:mobile_qiita_app/services/user.dart';

class Article {
  final String title;
  final String url;
  final String created_at;
  final int likes_count;
  final User user;

  Article({
    required this.title,
    required this.url,
    required this.created_at,
    required this.likes_count,
    required this.user
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      url: json['url'],
      created_at: json['created_at'],
      likes_count: json['likes_count'],
      user: User.fromJson(json['user']),
    );
  }
}