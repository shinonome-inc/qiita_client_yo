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
          : 'https://cdn.qiita.com/assets/icons/medium/missing-2e17009a0b32a6423572b0e6dc56727e.png',
      id: json['id'],
      itemsCount: json['items_count'],
    );
  }
}
