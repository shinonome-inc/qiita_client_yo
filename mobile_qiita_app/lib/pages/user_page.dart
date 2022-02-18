import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/variables.dart';
import 'package:mobile_qiita_app/components/app_bar_component.dart';
import 'package:mobile_qiita_app/components/list_components/posted_article_list_view.dart';
import 'package:mobile_qiita_app/components/user_component_of_user_page.dart';
import 'package:mobile_qiita_app/extension/connection_state_done.dart';
import 'package:mobile_qiita_app/extension/pagination_scroll.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/models/user.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:mobile_qiita_app/views/error_views.dart';

class UserPage extends StatefulWidget {
  const UserPage({required this.user, required this.appBarTitle, Key? key})
      : super(key: key);

  final User user;
  final String appBarTitle;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<Article>> _futureArticles;
  late List<Article> _fetchedArticles;
  int _currentPageNumber = 1;
  final String _searchWord = '';
  final String _tagId = '';
  bool _isNetworkError = false;
  bool _isLoading = false;
  final bool _isUserPage = true;

  // ユーザーのプロフィールと投稿記事一覧を表示
  Widget _userPageComponent() {
    return RefreshIndicator(
      onRefresh: _reload,
      child: Column(
        children: <Widget>[
          UserComponentOfUserPage(user: widget.user),
          Flexible(
            child: PostedArticleListView(
              onTapReload: _reload,
              articles: _fetchedArticles,
              scrollController: _scrollController,
              isUserPage: _isUserPage,
            ),
          ),
        ],
      ),
    );
  }

  // 再読み込み
  Future<void> _reload() async {
    setState(() {
      _futureArticles =
          QiitaClient.fetchArticle(_currentPageNumber, _searchWord, _tagId, '');
    });
  }

  // 記事を追加読み込み
  Future<void> _additionalLoading() async {
    if (!_isLoading) {
      _isLoading = true;
      _currentPageNumber++;
      setState(() {
        _futureArticles = QiitaClient.fetchArticle(
            _currentPageNumber, _searchWord, _tagId, '');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (Variables.accessToken.isNotEmpty) {
      _futureArticles =
          QiitaClient.fetchArticle(_currentPageNumber, _searchWord, _tagId, '');
    }
    _scrollController.addListener(() {
      if (_scrollController.isBottom) {
        _additionalLoading();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: widget.appBarTitle, useBackButton: false),
      body: Variables.accessToken.isNotEmpty
          ? SafeArea(
              child: FutureBuilder(
                future: _futureArticles,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  Widget child = Container();

                  if (snapshot.hasError) {
                    _isNetworkError = true;
                    child = ErrorView.networkErrorView(_reload);
                  } else if (_currentPageNumber != 1) {
                    child = _userPageComponent();
                  }

                  if (snapshot.connectionStateDone && snapshot.hasData) {
                    _isLoading = false;
                    _isNetworkError = false;
                    if (_currentPageNumber == 1) {
                      _fetchedArticles = snapshot.data;
                      child = _userPageComponent();
                    } else {
                      _fetchedArticles.addAll(snapshot.data);
                    }
                  } else if (snapshot.hasError) {
                    _isNetworkError = true;
                    child = ErrorView.networkErrorView(_reload);
                  } else if (_isNetworkError || _currentPageNumber == 1) {
                    child = CircularProgressIndicator();
                  }

                  return Container(
                    child: Center(
                      child: child,
                    ),
                  );
                },
              ),
            )
          : ErrorView.notLoginView(context),
    );
  }
}
