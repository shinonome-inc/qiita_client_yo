import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/components/article_component.dart';
import 'package:mobile_qiita_app/models/article.dart';

// 記事一覧をListViewで表示
class ArticleListView extends StatefulWidget {
  ArticleListView({
    required this.onTapReload,
    required this.articles,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  final Future<void> Function() onTapReload;
  final List<Article> articles;
  final ScrollController scrollController;

  @override
  _ArticleListViewState createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onTapReload,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.articles.length,
        controller: widget.scrollController,
        itemBuilder: (context, index) {
          return ArticleComponent(
            article: widget.articles[index],
            isUserPage: false,
          );
        },
      ),
    );
  }
}
