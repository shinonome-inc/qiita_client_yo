import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/models/tag.dart';
import 'package:mobile_qiita_app/widgets/widget_formats.dart';

class ViewFormats {
  // 記事一覧をListViewで表示
  static Widget articleListView(Future<void> Function() onTapReload,
      List<Article> articles, ScrollController scrollController) {
    final bool isUserPage = false;
    return RefreshIndicator(
      onRefresh: onTapReload,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: articles.length,
        controller: scrollController,
        itemBuilder: (context, index) {
          return WidgetFormats.articleFormat(
              context, articles[index], isUserPage);
        },
      ),
    );
  }

  // 記事一覧のListViewと「投稿記事」のラベルを表示
  static Widget postedArticleListView(
      Future<void> Function() onTapReload,
      List<Article> articles,
      ScrollController scrollController,
      bool isUserPage) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          color: const Color(0xFFF2F2F2),
          alignment: Alignment.centerLeft,
          child: const Text(
            '投稿記事',
            style: TextStyle(
              color: const Color(0xFF828282),
            ),
          ),
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: articles.length,
            controller: scrollController,
            itemBuilder: (context, index) {
              return WidgetFormats.articleFormat(
                  context, articles[index], isUserPage);
            },
          ),
        ),
      ],
    );
  }

  // タグ一覧をGridViewで表示
  static Widget tagGridView(
      Future<void> Function() onTapReload,
      List<Tag> fetchedTags,
      ScrollController scrollController,
      int tagContainerLength) {
    return RefreshIndicator(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: tagContainerLength,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          controller: scrollController,
          itemCount: fetchedTags.length,
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              WidgetFormats.tagFormat(context, fetchedTags[index]),
        ),
      ),
      onRefresh: onTapReload,
    );
  }
}
