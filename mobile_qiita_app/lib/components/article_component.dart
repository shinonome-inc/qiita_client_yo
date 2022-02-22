import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/common/methods.dart';
import 'package:mobile_qiita_app/models/article.dart';

// 取得した記事を基にユーザーアイコン、記事タイトル、ユーザー名、投稿日、LGTM数を表示
class ArticleComponent extends StatelessWidget {
  const ArticleComponent(
      {required this.article, required this.isUserPage, Key? key})
      : super(key: key);

  final Article article;
  final bool isUserPage;
  final String _headerTitle = 'article';

  Widget _userIcon() {
    return CircleAvatar(
      radius: 24,
      backgroundImage: CachedNetworkImageProvider(article.user.iconUrl),
    );
  }

  Widget _articleTitle() {
    return Text(
      article.title,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Widget _articleSubtitle() {
    final DateTime postedTime = DateTime.parse(article.createdAt);
    final String postedDate = Constants.postedDateFormat.format(postedTime);
    return Container(
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
        '@${article.user.id} 投稿日: $postedDate LGTM: ${article.likesCount}',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isUserPage
        ? ListTile(
            onTap: () {
              Methods.showWebContent(context, _headerTitle, article.url);
            },
            title: _articleTitle(),
            subtitle: _articleSubtitle(),
          )
        : ListTile(
            onTap: () {
              Methods.showWebContent(context, _headerTitle, article.url);
            },
            leading: _userIcon(),
            title: _articleTitle(),
            subtitle: _articleSubtitle(),
          );
  }
}
