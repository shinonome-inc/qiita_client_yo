// Qiita上のユーザー
import 'package:mobile_qiita_app/common/constants.dart';

class User {
  final String id;
  final String name;
  final String iconUrl;
  final String description;
  final int followingsCount;
  final int followersCount;

  User({
    required this.id,
    required this.name,
    required this.iconUrl,
    required this.description,
    required this.followingsCount,
    required this.followersCount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] != null ? json['name'] : '',
      iconUrl: json['profile_image_url'] != ''
          ? json['profile_image_url']
          : Constants.defaultUserIconUrl,
      description: json['description'] != null ? json['description'] : '',
      followingsCount: json['followees_count'],
      followersCount: json['followers_count'],
    );
  }
}
