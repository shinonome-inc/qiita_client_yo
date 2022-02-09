// アクセストークンに紐づいたユーザー
class AuthenticatedUser {
  final String id;
  final String name;
  final String thumbnail;
  final String description;
  final int followingsCount;
  final int followersCount;

  AuthenticatedUser({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.description,
    required this.followingsCount,
    required this.followersCount,
  });

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) {
    return AuthenticatedUser(
      id: json['id'],
      name: json['name'],
      thumbnail: json['profile_image_url'],
      description: json['description'],
      followingsCount: json['followees_count'],
      followersCount: json['followers_count'],
    );
  }
}
