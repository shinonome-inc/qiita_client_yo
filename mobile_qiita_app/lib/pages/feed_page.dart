import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/components/list_components/article_list_view.dart';
import 'package:mobile_qiita_app/components/searchable_app_bar_component.dart';
import 'package:mobile_qiita_app/extension/pagination_scroll.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:mobile_qiita_app/views/error_views.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<Article>> _futureArticles;
  List<Article> _fetchedArticles = [];
  int _currentPageNumber = 1;
  String _searchWord = '';
  final String _tagId = '';
  final String _userId = '';
  bool _isNetworkError = false;
  bool _isLoading = false;
  final String _appBarTitle = 'Feed';

  // Search Barに任意のテキストを入力して記事を検索
  void _searchArticles(String inputText) {
    _searchWord = inputText;
    setState(() {
      _futureArticles = QiitaClient.fetchArticle(
          _currentPageNumber, _searchWord, _tagId, _userId);
    });
  }

  // 再読み込み
  Future<void> _reload() async {
    setState(() {
      _futureArticles = QiitaClient.fetchArticle(
          _currentPageNumber, _searchWord, _tagId, _userId);
    });
  }

  // 記事を追加読み込み
  Future<void> _readAdditionally() async {
    if (!_isLoading) {
      _isLoading = true;
      _currentPageNumber++;
      setState(() {
        _futureArticles = QiitaClient.fetchArticle(
            _currentPageNumber, _searchWord, _tagId, _userId);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _futureArticles = QiitaClient.fetchArticle(
        _currentPageNumber, _searchWord, _tagId, _userId);
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
      appBar: SearchableAppBarComponent(
        title: _appBarTitle,
        searchArticles: _searchArticles,
      ),
      body: FutureBuilder(
        future: _futureArticles,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Widget child = Container();
          bool hasData = snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done;
          bool hasError = snapshot.hasError &&
              snapshot.connectionState == ConnectionState.done;
          bool isWaiting = (_isNetworkError || _currentPageNumber == 1) &&
              snapshot.connectionState == ConnectionState.waiting;
          bool isInitialized = _currentPageNumber != 1;
          bool isEmptySearchResult = snapshot.data == 0;

          if (isInitialized) {
            child = ArticleListView(
              onTapReload: _reload,
              articles: _fetchedArticles,
              scrollController: _scrollController,
            );
          }

          if (hasData && isEmptySearchResult) {
            _isLoading = false;
            _isNetworkError = false;
            child = ErrorView.emptySearchResultView();
          } else if (hasData && isInitialized) {
            _isLoading = false;
            _isNetworkError = false;
            _fetchedArticles.addAll(snapshot.data);
          } else if (hasData) {
            _isLoading = false;
            _isNetworkError = false;
            _fetchedArticles = snapshot.data;
            child = ArticleListView(
              onTapReload: _reload,
              articles: _fetchedArticles,
              scrollController: _scrollController,
            );
          } else if (hasError) {
            _isNetworkError = true;
            child = ErrorView.networkErrorView(_reload);
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
    );
  }
}
