import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/models/user.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:mobile_qiita_app/views/error_views.dart';
import 'package:mobile_qiita_app/widgets/widget_formats.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late Future<List<Article>> _futureArticles;
  late Future<User> _futureUser;
  late User _fetchedUser;
  late List<Article> _fetchedArticles;
  bool _isNetworkError = false;
  bool _isLoading = false;
  int _currentPageNumber = 1;
  final String _searchWord = '';
  final String _tagId = '';

  // 再読み込み
  Future<void> _reload() async {
    setState(() {
      _futureUser = QiitaClient.fetchUser();
      _futureArticles =
          QiitaClient.fetchArticle(_currentPageNumber, _searchWord, _tagId);
    });
  }

  @override
  void initState() {
    super.initState();
    _futureUser = QiitaClient.fetchUser();
    _futureArticles =
        QiitaClient.fetchArticle(_currentPageNumber, _searchWord, _tagId);
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
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: Future.wait([_futureUser, _futureArticles]),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              _fetchedUser = snapshot.data[0];
              _fetchedArticles = snapshot.data[1];
              Widget child = Container();

              if (snapshot.hasError) {
                _isNetworkError = true;
                child = ErrorView.networkErrorView(_reload);
              } else if (snapshot.hasError) {
                child = ErrorView.notLoginView();
              } else if (_currentPageNumber != 1) {
                child = WidgetFormats.userFormat(_fetchedUser);
              }

              if (snapshot.connectionState == ConnectionState.done) {
                _isLoading = false;
                if (snapshot.hasData) {
                  _isNetworkError = false;
                  child = WidgetFormats.userFormat(_fetchedUser);
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
        ),
      ),
    );
  }
}
