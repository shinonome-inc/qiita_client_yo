import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_qiita_app/common/methods.dart';
import 'package:mobile_qiita_app/components/cached_network_image_icon.dart';
import 'package:mobile_qiita_app/models/article.dart';

// 取得した記事を基にユーザーアイコン、記事タイトル、ユーザー名、投稿日、LGTM数を表示
class ArticleComponent extends StatelessWidget {
  const ArticleComponent(
      {required this.article, required this.isUserPage, Key? key})
      : super(key: key);

  final Article article;
  final bool isUserPage;
  final String _headerTitle = 'article';

  Widget _articleTitle() {
    return Text(
      article.title,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  Widget _articleSubtitle() {
    final DateTime postedTime = DateTime.parse(article.createdAt);
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final String postedDate = dateFormat.format(postedTime);
    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFB2B2B2),
            width: 0.5,
          ),
        ),
      ),
      child: Text(
        '@${article.user.id} 投稿日: $postedDate LGTM: ${article.likesCount}',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isUserPage
        ? ListTile(
            onTap: () {
              Methods.showScrollableModalBottomSheet(
                  context, _headerTitle, article.url);
            },
            title: _articleTitle(),
            subtitle: _articleSubtitle(),
          )
        : ListTile(
            onTap: () {
              Methods.showScrollableModalBottomSheet(
                  context, _headerTitle, article.url);
            },
            leading: CachedNetworkImageIcon(imageUrl: article.user.iconUrl),
            title: _articleTitle(),
            subtitle: _articleSubtitle(),
          );
  }
}
