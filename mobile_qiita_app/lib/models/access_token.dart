class AccessToken {
  final String token;

  AccessToken({required this.token});

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
      token: json['token'],
    );
  }
}
