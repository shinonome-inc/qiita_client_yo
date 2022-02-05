import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/extension/pagination_scroll.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/services/client.dart';
import 'package:mobile_qiita_app/views/error_views.dart';
import 'package:mobile_qiita_app/widgets/article_widget.dart';

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
  bool _isNetworkError = false;
  bool _isLoading = false;

  // 取得した記事一覧をListViewで表示
  Widget _articleListView() {
    return RefreshIndicator(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _fetchedArticles.length,
        controller: _scrollController,
        itemBuilder: (context, index) {
          return ArticleWidget.articleWidget(context, _fetchedArticles[index]);
        },
      ),
      onRefresh: _reload,
    );
  }

  // Search Barに任意のテキストを入力して記事を検索
  void _searchArticles(String inputText) {
    _searchWord = inputText;
    setState(() {
      _futureArticles = Client.fetchArticle(_currentPageNumber, _searchWord);
    });
  }

  // 再読み込み
  Future<void> _reload() async {
    setState(() {
      _futureArticles = Client.fetchArticle(_currentPageNumber, _searchWord);
    });
  }

  // 記事を追加読み込み
  Future<void> _moreLoad() async {
    if (!_isLoading) {
      _isLoading = true;
      _currentPageNumber++;
      setState(() {
        _futureArticles = Client.fetchArticle(_currentPageNumber, _searchWord);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _futureArticles = Client.fetchArticle(_currentPageNumber, _searchWord);
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: const Color(0xEFEFF0FF),
                width: 1.6,
              ),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  height: 64.0,
                  alignment: Alignment.center,
                  child: const Text(
                    'Feed',
                    style: Constants.headerTextStyle,
                  ),
                ),
                Container(
                  height: 40.0,
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  padding: const EdgeInsets.only(left: 8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xEFEFF0FF),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    enabled: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: const Icon(Icons.search),
                      hintText: 'Search',
                      hintStyle: TextStyle(
                        color: const Color(0xFF828282),
                        fontSize: 18.0,
                      ),
                    ),
                    onSubmitted: _searchArticles,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _futureArticles,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          Widget child = Container();

          if (snapshot.hasError) {
            _isNetworkError = true;
            child = ErrorView.networkErrorView(_reload);
          } else if (_currentPageNumber != 1) {
            child = _articleListView();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            _isLoading = false;
            if (snapshot.hasData) {
              _isNetworkError = false;
              if (snapshot.data.length == 0) {
                child = ErrorView.emptySearchResultView();
              } else if (_currentPageNumber == 1) {
                _fetchedArticles = snapshot.data;
                child = _articleListView();
              } else {
                _fetchedArticles.addAll(snapshot.data);
              }
            } else if (snapshot.hasError) {
              _isNetworkError = true;
              child = ErrorView.networkErrorView(_reload);
            }
          } else {
            if (_isNetworkError || _currentPageNumber == 1) {
              child = CircularProgressIndicator();
            }
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
