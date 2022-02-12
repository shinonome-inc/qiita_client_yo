import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/models/user.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:mobile_qiita_app/views/error_views.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  late Future<User> _futureAuthenticatedUser;
  late User _fetchedAuthenticatedUser;
  bool _isNetworkError = false;
  bool _isLoading = false;

  Widget _userFormat(User user) {
    String userIconUrl =
        user.iconUrl.isNotEmpty ? user.iconUrl : Constants.defaultUserIconUrl;

    return Container(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 24.0,
            backgroundImage: CachedNetworkImageProvider(userIconUrl),
          ),
          Text(user.name),
          Text(user.id),
          Text(user.description),
          Text('${user.followingsCount}フォロー中 ${user.followersCount}フォロワー'),
        ],
      ),
    );
  }

  // 再読み込み
  Future<void> _reload() async {
    setState(() {
      _futureAuthenticatedUser = QiitaClient.fetchUser();
    });
  }

  @override
  void initState() {
    super.initState();
    _futureAuthenticatedUser = QiitaClient.fetchUser();
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
