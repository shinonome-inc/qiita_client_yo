import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/components/follows_followers_button.dart';
import 'package:mobile_qiita_app/models/user.dart';

// 取得したユーザー情報を基にユーザーアイコン、ユーザー名、ID、自己紹介、フォロー数、フォロワー数を表示
class UserComponentOfUserPage extends StatelessWidget {
  const UserComponentOfUserPage({required this.user, Key? key})
      : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: 24.0, top: 20.0, right: 24.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(bottom: 16.0),
            child: CircleAvatar(
              radius: 40.0,
              backgroundImage: CachedNetworkImageProvider(user.iconUrl),
            ),
          ),
          Text(
            user.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4.0),
          Text(
            '@${user.id}',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(color: Constants.lightSecondaryGrey),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              user.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Constants.lightSecondaryGrey),
            ),
          ),
          Row(
            children: <Widget>[
              FollowsFollowersButton(user: user, usersType: 'Follows'),
              SizedBox(width: 8.0),
              FollowsFollowersButton(user: user, usersType: 'Followers'),
            ],
          ),
        ],
      ),
    );
  }
}
