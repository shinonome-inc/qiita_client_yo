import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/services/client.dart';
import 'package:mobile_qiita_app/services/article.dart';
import 'package:mobile_qiita_app/views/error_views.dart';
import 'package:mobile_qiita_app/pages/qiita_article_page.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  late Future<List<Article>> _futureArticles;

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

  // 再読み込みする
  void _reload() {
    setState(() {
      _futureArticles = Client.fetchArticle();
    });
  }

  @override
  void initState() {
    super.initState();
    _futureArticles = Client.fetchArticle();
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
                    onChanged: (e) {
                      print(e);
                      // ・Search Barに任意のテキストを入力すると記事の検索ができる
                    },
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
            if (snapshot.hasData) {
              children = <Widget> [
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return _articleWidget(snapshot.data[index]);
                    },
                  ),
                ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: _reload,
        child: const Text('reload'),
      ),
    );
  }
}
