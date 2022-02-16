import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/common/variables.dart';
import 'package:mobile_qiita_app/models/article.dart';
import 'package:mobile_qiita_app/models/user.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:mobile_qiita_app/views/error_views.dart';
import 'package:mobile_qiita_app/widgets/widget_formats.dart';

class UserPage extends StatefulWidget {
  const UserPage({required this.user, required this.appBarTitle, Key? key})
      : super(key: key);

  final User user;
  final String appBarTitle;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final ScrollController _scrollController = ScrollController();
  late Future<List<Article>> _futureArticles;
  late List<Article> _fetchedArticles;
  int _currentPageNumber = 1;
  final String _searchWord = '';
  final String _tagId = '';
  bool _isNetworkError = false;
  bool _isLoading = false;

  // 再読み込み
  Future<void> _reload() async {
    setState(() {
      _futureArticles = QiitaClient.fetchArticle(
          _currentPageNumber, _searchWord, _tagId, widget.user.id);
    });
  }

  @override
  void initState() {
    super.initState();
    if (Variables.accessToken.isNotEmpty) {
      _futureArticles = QiitaClient.fetchArticle(
          _currentPageNumber, _searchWord, _tagId, widget.user.id);
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
        title: Text(
          widget.appBarTitle,
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
                    child = WidgetFormats.userPageFormat(_reload, widget.user,
                        _fetchedArticles, _scrollController, context);
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    _isLoading = false;
                    if (snapshot.hasData) {
                      _isNetworkError = false;
                      _fetchedArticles = snapshot.data;
                      child = WidgetFormats.userPageFormat(_reload, widget.user,
                          _fetchedArticles, _scrollController, context);
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
