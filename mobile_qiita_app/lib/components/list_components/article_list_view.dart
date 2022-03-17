import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/components/article_component.dart';
import 'package:mobile_qiita_app/models/article.dart';

// 記事一覧のListView
class ArticleListView extends StatefulWidget {
  ArticleListView({
    required this.articles,
    required this.scrollController,
    this.isUserPage = false,
    this.showPostedArticlesLabel = false,
    Key? key,
  }) : super(key: key);

  final List<Article> articles;
  final ScrollController scrollController;
  final bool showPostedArticlesLabel;
  final bool isUserPage;

  @override
  _ArticleListViewState createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.showPostedArticlesLabel)
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
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.articles.length,
            controller: widget.scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ArticleComponent(
                article: widget.articles[index],
                isUserPage: widget.isUserPage,
              );
            },
          ),
        ),
      ],
    );
  }
}
