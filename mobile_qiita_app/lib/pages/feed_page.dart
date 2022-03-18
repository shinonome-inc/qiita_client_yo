import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/components/list_components/article_list_view.dart';
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
  final TextEditingController _textEditingController = TextEditingController();
  late Future<List<Article>> _futureArticles;
  List<Article> _fetchedArticles = [];

  int _currentPageNumber = 1;
  String _searchWord = '';
  final String _tagId = '';
  final String _userId = '';

  bool _isNetworkError = false;
  bool _isLoading = false;
  bool _isEmptySearchResult = false;

  Size get preferredSize => Size.fromHeight(kToolbarHeight + 48.0);

  Widget _textFieldIcon() {
    return GestureDetector(
      onTap: () {
        _searchForArticlesFromInputText(_textEditingController.text);
      },
      child: const Icon(
        Icons.search,
        color: Color(0xFF8E8E93),
      ),
    );
  }

  Widget _textFieldSuffixIcon() {
    if (_textEditingController.text.isEmpty) {
      return SizedBox.shrink();
    }
    return GestureDetector(
      onTap: () {
        _textEditingController.text = '';
      },
      child: const Icon(
        Icons.close,
        color: Color(0xFF8E8E93),
      ),
    );
  }

  PreferredSize? _searchableAppBar() {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: const Color(0xFFCFCFCF),
              width: 0.2,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 27.0),
              child: const Text(
                'Feed',
                style: Constants.appBarTextStyle,
              ),
            ),
            Container(
              height: 36.0,
              margin: const EdgeInsets.only(bottom: 8.0),
              padding: const EdgeInsets.only(left: 8.0),
              decoration: BoxDecoration(
                color: const Color(0xEFEFF0FF),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                enabled: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: _textFieldIcon(),
                  suffixIcon: _textFieldSuffixIcon(),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: const Color(0xFF8E8E93),
                    fontSize: 17.0,
                  ),
                ),
                controller: _textEditingController,
                onSubmitted: _searchForArticlesFromInputText,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetFetchArticles() {
    _currentPageNumber = 1;
    _fetchedArticles.clear();
    setState(() {
      _futureArticles = QiitaClient.fetchArticles(
          _currentPageNumber, _searchWord, _tagId, _userId);
    });
  }

  void _searchForArticlesFromInputText(String inputText) {
    _searchWord = inputText;
    _resetFetchArticles();
  }

  Future<void> _reload() async {
    if (_isEmptySearchResult) {
      setState(() {
        _isEmptySearchResult = false;
        _searchWord = '';
        _textEditingController.text = '';
      });
    }
    _resetFetchArticles();
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
    return SafeArea(
      child: GestureDetector(
        onPanDown: (details) {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: _searchableAppBar(),
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
                _isEmptySearchResult = hasData && snapshot.data.length == 0;

                if (isInitialized) {
                  child = ArticleListView(
                    articles: _fetchedArticles,
                    scrollController: _scrollController,
                  );
                }

                if (_isEmptySearchResult) {
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
      ),
    );
  }
}
