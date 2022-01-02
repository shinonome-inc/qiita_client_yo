import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/services/client.dart';
import 'package:mobile_qiita_app/services/article.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:mobile_qiita_app/views/error_views.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  late Future<List<Article>> _futureArticles;
  late List<Article> _resultArticles;
  final ScrollController _scrollController = ScrollController();
  int _pageNumber = 1;
  String _searchWord = '';

  // 取得した記事の内容を整理して表示
  Widget _articleWidget(Article article) {
    return ListTile(
      onTap: () {
        _showArticle(article);
      },
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: NetworkImage(article.user.iconUrl),
      ),
      title: Text(
        article.title,
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
          '${article.user.id} 投稿日: ${article.created_at.substring(0, 10)} LGTM: ${article.likes_count}',
        ),
      ),
    );
  }

  // ・記事項目タップで13-Qiita Article Pageへ遷移する
  void _showArticle(Article article) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.95,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0)),
                color: const Color(0xF7F7F7FF),
              ),
              height: 59.0,
              child: Center(
                child: const Text(
                  'Article',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: WebView(
                initialUrl: article.url,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 再読み込みする
  void _reload() {
    setState(() {
      _futureArticles = Client.fetchArticle(_pageNumber, _searchWord);
    });
  }

  // 記事をさらに読み込む
  Future<void> _moreLoad() async {
    Future<List<Article>> _futureNextArticles;

    _pageNumber++;
    _futureNextArticles = Client.fetchArticle(_pageNumber, _searchWord);

    for (var i = 0; i < _pageNumber; i++) {
      setState(() {
        _futureArticles = Client.fetchArticle(_pageNumber, _searchWord);
      });
    }
  }

  // Search Barに任意のテキストを入力すると記事の検索ができる
  void _searchArticles(String inputText) {
    _searchWord = inputText;
    setState(() {
      _futureArticles = Client.fetchArticle(_pageNumber, _searchWord);
    });
  }

  // 検索結果が0件だった場合に表示
  Widget _emptySearchResultView() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
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
            const SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _futureArticles = Client.fetchArticle(_pageNumber, _searchWord);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
        print('下端');
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
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Pacifico',
                      fontSize: 22.0,
                    ),
                  ),
                ),
                Container(
                  width: 380.0,
                  height: 40.0,
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
                      hintText: 'search',
                      hintStyle: TextStyle(
                        color: const Color(0xFF828282),
                        fontSize: 18.0,
                      ),
                    ),
                    onChanged: _searchArticles,
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
          List<Widget> children = [];
          MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start;
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data.length != 0) {
              if (_pageNumber == 1) {
                _resultArticles = snapshot.data;
              }
              else {
                _resultArticles.addAll(snapshot.data);
              }
              children = <Widget> [
                Flexible(
                  child: RefreshIndicator(
                    onRefresh: _moreLoad,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _resultArticles.length,
                      controller: _scrollController,
                      itemBuilder: (context, index) {
                        return _articleWidget(_resultArticles[index]);
                      },
                    ),
                  ),
                ),
              ];
            }
            else if (snapshot.hasData) {
              children = <Widget> [
                _emptySearchResultView(),
              ];
            }
            else if (snapshot.hasError) {
              children = <Widget> [
                ErrorView.errorViewWidget(_reload),
              ];
            }
          }
          else {
            mainAxisAlignment = MainAxisAlignment.center;
            children = <Widget> [
              Center(
                child: CircularProgressIndicator(),
              ),
            ];
          }
          return Column(
            mainAxisAlignment: mainAxisAlignment,
            children: children,
          );
        },
      ),
    );
  }
}
