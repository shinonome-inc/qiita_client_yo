import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/common/methods.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/models/tag.dart';
import 'package:mobile_qiita_app/models/user.dart';
import 'package:mobile_qiita_app/pages/tag_detail_list_page.dart';

class WidgetFormats {
  // 取得した記事を基にユーザーアイコン、記事タイトル、ユーザー名、投稿日、LGTM数を表示
  static Widget articleFormat(BuildContext context, Article article) {
    DateTime postedTime = DateTime.parse(article.createdAt);
    String postedDate = Constants.postedDateFormat.format(postedTime);
    String userIconUrl = article.user.iconUrl.isEmpty
        ? Constants.defaultUserIconUrl
        : article.user.iconUrl;
    return ListTile(
      onTap: () {
        Methods.showWebContent(context, 'article', article.url);
      },
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: CachedNetworkImageProvider(userIconUrl),
      ),
      title: Text(
        article.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      subtitle: Container(
        padding: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: const Color(0xEFEFF0FF),
              width: 1.0,
            ),
          ),
        ),
        child: Text(
          '${article.user.id} 投稿日: $postedDate LGTM: ${article.likesCount}',
        ),
      ),
    );
  }

  // 取得したタグを基にアイコン、タグ名、記事件数、フォロワー数を表示
  static Widget tagFormat(BuildContext context, Tag tag) {
    String tagIconUrl =
        tag.iconUrl.isEmpty ? Constants.defaultTagIconUrl : tag.iconUrl;
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
              child: CachedNetworkImage(imageUrl: tagIconUrl),
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
  static Widget userFormat(User user) {
    String userIconUrl =
        user.iconUrl.isNotEmpty ? user.iconUrl : Constants.defaultUserIconUrl;
    return Container(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 24.0,
            backgroundImage: CachedNetworkImageProvider(userIconUrl),
          ),
          Text(user.name),
          Text(user.id),
          Text(user.description),
          Text('${user.followingsCount}フォロー中 ${user.followersCount}フォロワー'),
        ],
      ),
    );
  }
}
