import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/models/tag.dart';
import 'package:mobile_qiita_app/widgets/widget_formats.dart';

class ViewFormats {
  // 記事一覧をListViewで表示
  static Widget articleListView(Future<void> Function() onTapReload,
      List<Article> fetchedArticles, ScrollController scrollController) {
    return Flexible(
      child: RefreshIndicator(
        onRefresh: onTapReload,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: fetchedArticles.length,
          controller: scrollController,
          itemBuilder: (context, index) {
            return WidgetFormats.articleFormat(context, fetchedArticles[index]);
          },
        ),
      ),
    );
  }

  // 投稿記事一覧を表示
  static Widget postedArticleListView(Future<void> Function() onTapReload,
      List<Article> fetchedArticles, ScrollController scrollController) {
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
        articleListView(onTapReload, fetchedArticles, scrollController),
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
