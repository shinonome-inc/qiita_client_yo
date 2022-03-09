import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/components/app_bar_component.dart';
import 'package:mobile_qiita_app/components/list_components/posted_article_list_view.dart';
import 'package:mobile_qiita_app/extension/pagination_scroll.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/models/tag.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:mobile_qiita_app/views/network_error_view.dart';

class TagDetailListPage extends StatefulWidget {
  const TagDetailListPage({required this.tag, Key? key}) : super(key: key);

  final Tag tag;

  @override
  _TagDetailListPageState createState() => _TagDetailListPageState();
}

class _TagDetailListPageState extends State<TagDetailListPage> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<Article>> _futureArticles;
  List<Article> _fetchedArticles = [];
  int _currentPageNumber = 1;
  final String _searchWord = '';
  String _tagId = '';
  final String _userId = '';
  final bool _isUserPage = false;
  bool _isNetworkError = false;
  bool _isLoading = false;

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
    _tagId = widget.tag.id;
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
      appBar: AppBarComponent(title: _tagId, useBackButton: true),
      body: FutureBuilder(
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
            child = PostedArticleListView(
              onTapReload: _reload,
              articles: _fetchedArticles,
              scrollController: _scrollController,
              isUserPage: _isUserPage,
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
            child = PostedArticleListView(
              onTapReload: _reload,
              articles: _fetchedArticles,
              scrollController: _scrollController,
              isUserPage: _isUserPage,
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
    );
  }
}
