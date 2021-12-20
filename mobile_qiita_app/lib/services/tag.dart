class Tag {
  final int followers_count;
  final String icon_url;
  final String id;
  final int items_count;

  Tag({
    required this.followers_count,
    required this.icon_url,
    required this.id,
    required this.items_count,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      followers_count: json['followers_count'],
      icon_url: (json['icon_url'] != null) ? json['icon_url'] : '',
      id: json['id'],
      items_count: json['items_count'],
    );
  }
}