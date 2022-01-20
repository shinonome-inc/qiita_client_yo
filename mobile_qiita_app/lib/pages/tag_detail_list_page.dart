import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/constants.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/models/tag.dart';
import 'package:mobile_qiita_app/pages/qiita_article_page.dart';
import 'package:mobile_qiita_app/services/client.dart';
import 'package:mobile_qiita_app/views/error_views.dart';

class TagDetailListPage extends StatefulWidget {
  const TagDetailListPage({ required this.tag, Key? key}) : super(key: key);

  final Tag tag;

  @override
  _TagDetailListPageState createState() => _TagDetailListPageState();
}

class _TagDetailListPageState extends State<TagDetailListPage> {
  late Future<List<Article>> _futureArticles;
  String _tagId = '';

  // 取得した記事の内容を整理して表示
  Widget _articleWidget(Article article) {
    DateTime postedTime = DateTime.parse(article.createdAt);
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
        article.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
      subtitle: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: const Color(0xE2E2E2FF),
              width: 1.0,
            ),
          ),
        ),
        child: Text(
          '${article.user.id} 投稿日: $postedDate LGTM: ${article.likesCount}',
        ),
      ),
    );
  }

  // 記事一覧をListで表示
  Widget _articleListView(List<Article> articles) {
    return Flexible(
      child: RefreshIndicator(
        onRefresh: _reload,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return _articleWidget(articles[index]);
          },
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
  Future<void> _reload() async {
    setState(() {
      _futureArticles = Client.fetchTagDetail(_tagId);
    });
  }

  @override
  void initState() {
    super.initState();
    _tagId = widget.tag.id;
    _futureArticles = Client.fetchTagDetail(_tagId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: const Color(0xFF468300),
            ),
          ),
          title: Text(
            _tagId,
            style: Constants.headerTextStyle,
          ),
        ),
        body: FutureBuilder(
          future: _futureArticles,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List<Widget> children = [];

            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                children = <Widget> [
                  Container(
                    color: const Color(0xFFF2F2F2),
                    alignment: Alignment.centerLeft,
                    child: const Text('投稿記事'),
                  ),
                  _articleListView(snapshot.data),
                ];
              }
              else if (snapshot.hasError) {
                children = <Widget> [
                  ErrorView.errorViewWidget(_reload),
                ];
              }
            }
            else {
              children = <Widget> [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ];
            }
            return Column(
              mainAxisAlignment: snapshot.connectionState == ConnectionState.done
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: children,
            );
          },
        )
    );
  }
}