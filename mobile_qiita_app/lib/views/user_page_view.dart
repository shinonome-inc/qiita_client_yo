import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/components/list_components/posted_article_list_view.dart';
import 'package:mobile_qiita_app/components/user_component_of_user_page.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/models/user.dart';

// ユーザーのプロフィールと投稿記事一覧を表示
class UserPageView extends StatefulWidget {
  UserPageView({
    required this.onTapReload,
    required this.user,
    required this.articles,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  final Future<void> Function() onTapReload;
  final User user;
  final List<Article> articles;
  final ScrollController scrollController;

  @override
  _UserPageViewState createState() => _UserPageViewState();
}

class _UserPageViewState extends State<UserPageView> {
  final _isUserPage = true;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.onTapReload,
      child: Column(
        children: <Widget>[
          UserComponentOfUserPage(user: widget.user),
          Flexible(
            child: PostedArticleListView(
              onTapReload: widget.onTapReload,
              articles: widget.articles,
              scrollController: widget.scrollController,
              isUserPage: _isUserPage,
            ),
          ),
        ],
      ),
    );
  }
}
