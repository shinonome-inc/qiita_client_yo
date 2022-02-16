import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/models/user.dart';

// ユーザーのアイコン、名前、ID、投稿数、紹介文を表示
class UserComponentOfUserList extends StatelessWidget {
  const UserComponentOfUserList({required this.user, Key? key})
      : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: UserPageへ遷移
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1.0,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: CachedNetworkImageProvider(user.iconUrl),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          user.name,
                        ),
                        Text(
                          '@${user.id}',
                          style: TextStyle(
                              color: const Color(0xFF828282), fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Posts: ${user.posts}',
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Text(
                user.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style:
                    TextStyle(color: const Color(0xFF828282), fontSize: 12.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
