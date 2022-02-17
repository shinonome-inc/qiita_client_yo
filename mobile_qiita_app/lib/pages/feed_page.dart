import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/components/searchable_app_bar_component.dart';
import 'package:mobile_qiita_app/extension/connection_state_done.dart';
import 'package:mobile_qiita_app/extension/pagination_scroll.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:mobile_qiita_app/views/error_views.dart';
import 'package:mobile_qiita_app/widgets/view_formats.dart';

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
  Future<void> _moreLoad() async {
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
        _moreLoad();
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

          if (snapshot.hasError) {
            _isNetworkError = true;
            child = ErrorView.networkErrorView(_reload);
          } else if (_currentPageNumber != 1) {
            child = ViewFormats.articleListView(
                _reload, _fetchedArticles, _scrollController);
          }

          if (snapshot.connectionStateDone && snapshot.hasData) {
            _isLoading = false;
            _isNetworkError = false;
            if (snapshot.data.length == 0) {
              child = ErrorView.emptySearchResultView();
            } else if (_currentPageNumber == 1) {
              _fetchedArticles = snapshot.data;
              child = ViewFormats.articleListView(
                  _reload, _fetchedArticles, _scrollController);
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
    );
  }
}
