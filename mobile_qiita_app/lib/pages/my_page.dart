import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/common/variables.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/models/user.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:mobile_qiita_app/views/error_views.dart';
import 'package:mobile_qiita_app/widgets/view_formats.dart';
import 'package:mobile_qiita_app/widgets/widget_formats.dart';
import 'package:mobile_qiita_app/widgets/widget_parts.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<Article>> _futureArticles;
  late User _fetchedUser;
  late List<Article> _fetchedArticles;
  int _currentPageNumber = 1;
  final String _searchWord = '';
  final String _tagId = '';
  late final String _userId;
  final bool _isUserPosts = true;
  bool _isNetworkError = false;
  bool _isLoading = false;

  // 投稿記事
  Widget _postedArticleList() {
    return Column(
      children: <Widget>[
        WidgetFormats.userFormat(_fetchedUser),
        WidgetParts.postedArticleLabel,
        ViewFormats.articleListView(
            _reload, _fetchedArticles, _scrollController, _isUserPosts),
      ],
    );
  }

  // 再読み込み
  Future<void> _reload() async {
    setState(() {
      _futureArticles = QiitaClient.fetchArticle(
          _currentPageNumber, _searchWord, _tagId, _userId);
    });
  }

  @override
  void initState() {
    super.initState();
    if (Variables.accessToken.isNotEmpty) {
      _fetchedUser = Variables.authenticatedUser;
      _userId = _fetchedUser.id;
      _futureArticles = QiitaClient.fetchArticle(
          _currentPageNumber, _searchWord, _tagId, _userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 1.6,
        title: const Text(
          'MyPage',
          style: Constants.headerTextStyle,
        ),
      ),
      body: Variables.accessToken.isNotEmpty
          ? SafeArea(
              child: FutureBuilder(
                future: _futureArticles,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  Widget child = Container();

                  if (snapshot.hasError) {
                    _isNetworkError = true;
                    child = ErrorView.networkErrorView(_reload);
                  } else if (_currentPageNumber != 1) {
                    _fetchedArticles = snapshot.data;
                    child = _postedArticleList();
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    _isLoading = false;
                    if (snapshot.hasData) {
                      _isNetworkError = false;
                      _fetchedArticles = snapshot.data;
                      child = _postedArticleList();
                    } else if (snapshot.hasError) {
                      _isNetworkError = true;
                      child = ErrorView.networkErrorView(_reload);
                    }
                  } else {
                    child = CircularProgressIndicator();
                  }

                  return Container(
                    child: Center(
                      child: child,
                    ),
                  );
                },
              ),
            )
          : ErrorView.notLoginView(context),
    );
  }
}
