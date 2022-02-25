import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/components/article_component.dart';
import 'package:mobile_qiita_app/models/article.dart';

// 記事一覧のListViewと「投稿記事」のラベルを表示
class PostedArticleListView extends StatefulWidget {
  PostedArticleListView({
    required this.onTapReload,
    required this.articles,
    required this.scrollController,
    required this.isUserPage,
    Key? key,
  }) : super(key: key);

  final Future<void> Function() onTapReload;
  final List<Article> articles;
  final ScrollController scrollController;
  final bool isUserPage;

  @override
  _PostedArticleListViewState createState() => _PostedArticleListViewState();
}

class _PostedArticleListViewState extends State<PostedArticleListView> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Container(
        color: Constants.gray6,
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.only(left: 12.0, top: 8.0, bottom: 8.0),
          child: const Text(
            '投稿記事',
            style: TextStyle(
              fontSize: 12.0,
              color: Constants.lightSecondaryGrey,
            ),
          ),
        ),
      ),
      widget.articles.length < 20
          ? RefreshIndicator(
              onRefresh: widget.onTapReload,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.articles.length,
                controller: widget.scrollController,
                itemBuilder: (context, index) {
                  return ArticleComponent(
                    article: widget.articles[index],
                    isUserPage: widget.isUserPage,
                  );
                },
              ),
            )
          : Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.articles.length,
                controller: widget.scrollController,
                itemBuilder: (context, index) {
                  return ArticleComponent(
                    article: widget.articles[index],
                    isUserPage: widget.isUserPage,
                  );
                },
              ),
            ),
    ];

    return widget.articles.length < 20
        ? ListView(children: children)
        : Column(children: children);
  }
}
