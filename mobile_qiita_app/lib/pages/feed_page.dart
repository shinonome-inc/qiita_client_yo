import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/components/list_components/article_list_view.dart';
import 'package:mobile_qiita_app/components/searchable_app_bar_component.dart';
import 'package:mobile_qiita_app/extension/pagination_scroll.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:mobile_qiita_app/views/empty_serch_result_view.dart';
import 'package:mobile_qiita_app/views/network_error_view.dart';

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

  void _searchForArticlesFromInputText(String inputText) {
    _searchWord = inputText;
    setState(() {
      _futureArticles = QiitaClient.fetchArticles(
          _currentPageNumber, _searchWord, _tagId, _userId);
    });
  }

  Future<void> _reload() async {
    _currentPageNumber = 1;
    _fetchedArticles.clear();
    setState(() {
      _futureArticles = QiitaClient.fetchArticles(
          _currentPageNumber, _searchWord, _tagId, _userId);
    });
  }

  Future<void> _loadAdditionalArticles() async {
    if (!_isLoading) {
      _isLoading = true;
      _currentPageNumber++;
      setState(() {
        _futureArticles = QiitaClient.fetchArticles(
            _currentPageNumber, _searchWord, _tagId, _userId);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _futureArticles = QiitaClient.fetchArticles(
        _currentPageNumber, _searchWord, _tagId, _userId);
    _scrollController.addListener(() {
      if (_scrollController.isBottom) {
        _loadAdditionalArticles();
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
    return GestureDetector(
      onPanDown: (details) {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: SearchableAppBarComponent(
          title: 'Feed',
          searchArticles: _searchForArticlesFromInputText,
        ),
        body: RefreshIndicator(
          onRefresh: _reload,
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
              bool isEmptySearchResult = hasData && snapshot.data.length == 0;

              if (isInitialized) {
                child = ArticleListView(
                  onTapReload: _reload,
                  articles: _fetchedArticles,
                  scrollController: _scrollController,
                );
              }

              if (isEmptySearchResult) {
                _isLoading = false;
                _isNetworkError = false;
                child = EmptySearchResultView();
              } else if (hasAdditionalData) {
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
                child = NetworkErrorView(onTapReload: _reload);
              } else if (isWaiting) {
                child = Center(child: CircularProgressIndicator());
              }

              return Container(
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
