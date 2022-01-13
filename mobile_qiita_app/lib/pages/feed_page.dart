// TODO: 関数_articleWidgetの引数indexは後で削除
// FIXME: 1回目だけ無限スクロールが上手く動作しないので修正が必要
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mobile_qiita_app/services/client.dart';
import 'package:mobile_qiita_app/services/article.dart';
import 'package:mobile_qiita_app/views/error_views.dart';
import 'package:mobile_qiita_app/pages/qiita_article_page.dart';
import 'package:mobile_qiita_app/constants.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<Article>> _futureArticles;
  late List<Article> _resultArticles;
  int _currentPageNumber = 1;
  String _searchWord = '';
  bool _isNetworkError = false;
  bool _isLoading = false;

  // 取得した記事の内容を整理して表示
  Widget _articleWidget(Article article, int index) {
    DateTime postedTime = DateTime.parse(article.created_at);
    String postedDate = Constants.postedDateFormat.format(postedTime);


    String userIconUrl = article.user.iconUrl;
    if (userIconUrl.isEmpty) {
      userIconUrl = Constants.defaultUserIconUrl;
    }

    return ListTile(
      onTap: () {
        _showArticle(article);
      },
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: CachedNetworkImageProvider(userIconUrl),
      ),
      title: Text(
        '$index: ${article.title}',
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      subtitle: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: const Color(0xEFEFF0FF),
              width: 1.0,
            ),
          ),
        ),
        child: Text(
          '${article.user.id} 投稿日: $postedDate LGTM: ${article.likes_count}',
        ),
      ),
    );
  }

  // 記事一覧をListで表示
  Widget _articleListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _resultArticles.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        return _articleWidget(_resultArticles[index], index);
      },
    );
  }

  // 記事項目タップで13-Qiita Article Pageへ遷移する
  void _showArticle(Article article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) => DraggableScrollableSheet(
        expand: false,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        initialChildSize: 0.95,
        builder: (context, scrollController) {
          return QiitaArticlePage(article: article);
        },
      ),
    );
  }

  // 検索結果が0件だった場合に表示
  Widget _emptySearchResultView() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '検索にマッチする記事はありませんでした',
              style: TextStyle(fontSize: 15.0),
            ),
            const SizedBox(height: 20.0),
            const Text(
              '検索条件を変えるなどして再度検索をしてください',
              style: TextStyle(color: const Color(0xFF828282)),
            ),
          ],
        ),
      ),
    );
  }

  // Search Barに任意のテキストを入力すると記事の検索ができる
  void _searchArticles(String inputText) {
    _searchWord = inputText;
    setState(() {
      _futureArticles = Client.fetchArticle(_currentPageNumber, _searchWord);
    });
  }

  // 再読み込みする
  Future<void> _reload() async {
    setState(() {
      _futureArticles = Client.fetchArticle(_currentPageNumber, _searchWord);
    });
  }

  // 記事を更に読み込む
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
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
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
        preferredSize: const Size.fromHeight(128.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: const Color(0xEFEFF0FF),
                width: 1.5,
              ),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
                  height: 70.0,
                  alignment: Alignment.center,
                  child: const Text(
                    'Feed',
                    style: Constants.headerTextStyle,
                  ),
                ),
                Container(
                  height: 40.0,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  padding: const EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    color: const Color(0xEFEFF0FF),
                    borderRadius: BorderRadius.circular(10.0),
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
          _isLoading = false;

          if (snapshot.hasError) {
            _isNetworkError = true;
            child = ErrorView.errorViewWidget(_reload);
          } else if (_currentPageNumber != 1) {
            child = _articleListView();
          }

          if (snapshot.connectionState == ConnectionState.done) {
            _isLoading = false;
            if (snapshot.hasData) {
              _isNetworkError = false;
              if (snapshot.data.length == 0) {
                child = _emptySearchResultView();
              } else if (_currentPageNumber == 1) {
                _resultArticles = snapshot.data;
                child = _articleListView();
              } else {
                _resultArticles.addAll(snapshot.data);
              }
            } else if (snapshot.hasError) {
              _isNetworkError = true;
              child = ErrorView.errorViewWidget(_reload);
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
