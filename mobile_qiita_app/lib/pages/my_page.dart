import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/models/authenticated_user.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:mobile_qiita_app/views/error_views.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late Future<AuthenticatedUser> _futureAuthenticatedUser;
  late AuthenticatedUser _fetchedAuthenticatedUser;
  bool _isNetworkError = false;
  bool _isLoading = false;

  Widget _userFormat(AuthenticatedUser authenticatedUser) {
    String userIconUrl = authenticatedUser.thumbnail.isNotEmpty
        ? authenticatedUser.thumbnail
        : Constants.defaultUserIconUrl;

    return Container(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 24.0,
            backgroundImage: CachedNetworkImageProvider(userIconUrl),
          ),
          Text(authenticatedUser.name),
          Text(authenticatedUser.id),
          Text(authenticatedUser.description),
          Text(
              '${authenticatedUser.followingsCount}フォロー中 ${authenticatedUser.followersCount}フォロワー'),
        ],
      ),
    );
  }

  // 再読み込み
  Future<void> _reload() async {
    setState(() {
      _futureAuthenticatedUser = QiitaClient.fetchAuthenticatedUser();
    });
  }

  @override
  void initState() {
    super.initState();
    _futureAuthenticatedUser = QiitaClient.fetchAuthenticatedUser();
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
            future: _futureAuthenticatedUser,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              Widget child = Container();

              if (snapshot.hasError) {
                _isNetworkError = true;
                child = ErrorView.networkErrorView(_reload);
              } else if (snapshot.hasError) {
                child = ErrorView.notLoginView();
              } else {
                child = _userFormat(snapshot.data);
              }

              if (snapshot.connectionState == ConnectionState.done) {
                _isLoading = false;
                if (snapshot.hasData) {
                  _isNetworkError = false;
                  _fetchedAuthenticatedUser = snapshot.data;
                  child = _userFormat(snapshot.data);
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
