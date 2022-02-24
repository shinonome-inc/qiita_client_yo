import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/models/user.dart';

// ユーザーのアイコン、名前、ID、投稿数、紹介文を表示
class UserComponentOfUserList extends StatelessWidget {
  const UserComponentOfUserList({required this.user, Key? key})
      : super(key: key);
  final User user;

  // FIXME: 実行はできるが、"Incorrect use of ParentDataWidget."というエラーが発生
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
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
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 32.0,
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 16,
                        backgroundImage:
                            CachedNetworkImageProvider(user.iconUrl),
                      ),
                      Flexible(
                        child: Container(
                          height: 32.0,
                          margin: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 20.0,
                                child: Text(
                                  // user.name,
                                  'なまええええええええええええええええええええええええ',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Container(
                                height: 12.0,
                                child: Text(
                                  // '@${user.id}',
                                  'iddddddddddddddddddddddddddddddddddddddddddddddd',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: const Color(0xFF828282),
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    // 'Posts: ${user.posts}',
                    'Posts: 999999999999999999999999999999999999999999999999',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
                Container(
                  child: Text(
                    //user.description,
                    '3行を超える長い自己紹介3行を超える長い自己紹介3行を超える長い自己紹介3行を超える長い自己紹介3行を超える長い自己紹介3行を超える長い自己紹介3行を超える長い自己紹介3行を超える長い自己紹介3行を超える長い自己紹介3行を超える長い自己紹介3行を超える長い自己紹介',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                        color: const Color(0xFF828282), fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
