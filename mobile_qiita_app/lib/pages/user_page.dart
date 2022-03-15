import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/variables.dart';
import 'package:mobile_qiita_app/components/app_bar_component.dart';
import 'package:mobile_qiita_app/extension/pagination_scroll.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/models/user.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:mobile_qiita_app/views/network_error_view.dart';
import 'package:mobile_qiita_app/views/user_page_view.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    required this.user,
    required this.appBarTitle,
    required this.useBackButton,
    Key? key,
  }) : super(key: key);

  final User user;
  final String appBarTitle;
  final bool useBackButton;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<Article>> _futureArticles;
  late User _user;
  late List<Article> _fetchedArticles;

  int _currentPageNumber = 1;
  final String _searchWord = '';
  final String _tagId = '';

  bool _isNetworkError = false;
  bool _isLoading = false;
  late final bool _isMyPage;

  // 再読み込み
  Future<void> _reload() async {
    if (_isMyPage) {
      _updateAuthenticatedUser();
    }
    setState(() {
      _futureArticles = QiitaClient.fetchArticles(
          _currentPageNumber, _searchWord, _tagId, _user.id);
    });
  }

  Future<void> _updateAuthenticatedUser() async {
    await QiitaClient.fetchAuthenticatedUser();
    setState(() {
      _user = Variables.authenticatedUser;
    });
  }

  // 記事を追加読み込み
  Future<void> _readAdditionally() async {
    if (!_isLoading) {
      _isLoading = true;
      _currentPageNumber++;
      setState(() {
        _futureArticles = QiitaClient.fetchArticles(
            _currentPageNumber, _searchWord, _tagId, _user.id);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _isMyPage = (widget.appBarTitle == 'MyPage');

    if (_isMyPage) {
      _updateAuthenticatedUser();
    }
    if (Variables.isAuthenticated) {
      _futureArticles = QiitaClient.fetchArticles(
          _currentPageNumber, _searchWord, _tagId, _user.id);
    }

    _scrollController.addListener(() {
      if (_scrollController.isBottom) {
        _readAdditionally();
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
      appBar: AppBarComponent(
          title: widget.appBarTitle, useBackButton: widget.useBackButton),
      body: SafeArea(
        child: FutureBuilder(
          future: _futureArticles,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Widget child = Container();

            bool isInitialized = _currentPageNumber != 1;
            bool hasData = snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done;
            bool hasAdditionalData = hasData && isInitialized;
            bool hasError = snapshot.hasError &&
                snapshot.connectionState == ConnectionState.done;
            bool isWaiting = (_isNetworkError || _currentPageNumber == 1) &&
                snapshot.connectionState == ConnectionState.waiting;

            if (isInitialized) {
              child = UserPageView(
                onTapReload: _reload,
                user: _user,
                articles: _fetchedArticles,
                scrollController: _scrollController,
              );
            }

            if (hasAdditionalData) {
              _isLoading = false;
              _isNetworkError = false;
              _fetchedArticles.addAll(snapshot.data);
            } else if (hasData) {
              _isLoading = false;
              _isNetworkError = false;
              _fetchedArticles = snapshot.data;
              child = UserPageView(
                onTapReload: _reload,
                user: _user,
                articles: _fetchedArticles,
                scrollController: _scrollController,
              );
            } else if (hasError) {
              _isNetworkError = true;
              child = NetworkErrorView(onTapReload: _reload);
            } else if (isWaiting) {
              child = CircularProgressIndicator();
            }

            return Container(
              child: Center(
                child: child,
              ),
            );
          },
        ),
      ),
    );
  }
}
