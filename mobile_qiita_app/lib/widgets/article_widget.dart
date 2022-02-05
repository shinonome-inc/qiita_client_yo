import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/common/methods.dart';
import 'package:mobile_qiita_app/models/article.dart';

class ArticleWidget {
  // 取得した記事を基にユーザーアイコン、記事タイトル、ユーザー名、投稿日、LGTM数を表示
  static Widget articleWidget(BuildContext context, Article article) {
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
}
