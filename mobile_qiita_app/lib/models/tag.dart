import 'package:mobile_qiita_app/common/constants.dart';

class Tag {
  final int followersCount;
  final String iconUrl;
  final String id;
  final int itemsCount;

  Tag({
    required this.followersCount,
    required this.iconUrl,
    required this.id,
    required this.itemsCount,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      followersCount: json['followers_count'],
      iconUrl: json['icon_url'] != null
          ? json['icon_url']
          : Constants.defaultTagIconUrl,
      id: json['id'],
      itemsCount: json['items_count'],
    );
  }
}
