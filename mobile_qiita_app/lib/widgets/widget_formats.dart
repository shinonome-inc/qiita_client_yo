import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/models/tag.dart';
import 'package:mobile_qiita_app/models/user.dart';
import 'package:mobile_qiita_app/pages/follows_followers_list_page.dart';
import 'package:mobile_qiita_app/pages/tag_detail_list_page.dart';
import 'package:mobile_qiita_app/widgets/view_formats.dart';

class WidgetFormats {
  // 取得したタグを基にアイコン、タグ名、記事件数、フォロワー数を表示
  static Widget tagFormat(BuildContext context, Tag tag) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 1.6,
        ),
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TagDetailListPage(tag: tag),
            ),
          );
        },
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 48.0,
              width: 48.0,
              child: CachedNetworkImage(imageUrl: tag.iconUrl),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                tag.id,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '記事件数: ${tag.itemsCount}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: const Color(0xFF828282),
                fontSize: 14.5,
              ),
            ),
            Text(
              'フォロワー数: ${tag.followersCount}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: const Color(0xFF828282),
                fontSize: 14.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 取得したユーザー情報を基にユーザーアイコン、ユーザー名、ID、自己紹介、フォロー数、フォロワー数を表示
  static Widget userFormat(User user, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(bottom: 16.0),
            child: CircleAvatar(
              radius: 24.0,
              backgroundImage: CachedNetworkImageProvider(user.iconUrl),
            ),
          ),
          Text(user.name),
          Text(
            '@${user.id}',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              user.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FollowsFollowersListPage(
                          usersType: 'Follows', userId: user.id),
                    ),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: '${user.followingsCount}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: 'フォロー中  ',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FollowsFollowersListPage(
                          usersType: 'Followers', userId: user.id),
                    ),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: '${user.followersCount}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: 'フォロワー',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ユーザーのプロフィールと投稿記事一覧を表示
  static Widget userPageFormat(
      Future<void> Function() onTapReload,
      User user,
      List<Article> articles,
      ScrollController scrollController,
      BuildContext context) {
    final bool isUserPage = true;
    return RefreshIndicator(
      onRefresh: onTapReload,
      child: Column(
        children: <Widget>[
          userFormat(user, context),
          Flexible(
            child: ViewFormats.postedArticleListView(
                onTapReload, articles, scrollController, isUserPage),
          ),
        ],
      ),
    );
  }
}
