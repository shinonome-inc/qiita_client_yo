// TODO: ページネーションの実装
// TODO: User Pageへ遷移

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/models/user.dart';
import 'package:mobile_qiita_app/services/qiita_client.dart';
import 'package:mobile_qiita_app/views/error_views.dart';

class FollowsFollowersListPage extends StatefulWidget {
  const FollowsFollowersListPage(
      {required this.usersType, required this.userId, Key? key})
      : super(key: key);

  final String usersType;
  final String userId;

  @override
  _FollowsFollowersListPageState createState() =>
      _FollowsFollowersListPageState();
}

class _FollowsFollowersListPageState extends State<FollowsFollowersListPage> {
  ScrollController _scrollController = ScrollController();
  late Future<List<User>> _futureUsers;
  List<User> _fetchedUsers = [];
  int _currentPageNumber = 1;
  String _usersType = '';
  String _userId = '';
  bool _isNetworkError = false;
  bool _isLoading = false;

  AppBar appBar(String appBarTitle) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: const Color(0xFF468300),
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      automaticallyImplyLeading: false,
      elevation: 1.6,
      title: Text(
        appBarTitle,
        style: Constants.headerTextStyle,
      ),
    );
  }

  // ユーザー情報を元にアイコン、名前、ID、記事投稿数、Contribution?、自己紹介文を表示
  Widget userFormat(BuildContext context, User user) {
    return GestureDetector(
      onTap: () {
        // TODO: UserPageへ遷移
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1.6,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 24,
                  backgroundImage: CachedNetworkImageProvider(user.iconUrl),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        user.name,
                      ),
                      Text(
                        '@${user.id}',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              // child: Text('Posts: ${user.posts}, Contribution: ${user.posts}'),
              child: Text('Posts: ${user.posts}'),
            ),
            Text(
              user.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ユーザー一覧を表示
  Widget usersListView() {
    return _fetchedUsers.length < 20
        ? RefreshIndicator(
            onRefresh: _reload,
            child: ListView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _fetchedUsers.length,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return userFormat(context, _fetchedUsers[index]);
                  },
                ),
              ],
            ),
          )
        : RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _fetchedUsers.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return userFormat(context, _fetchedUsers[index]);
              },
            ),
          );
  }

  // 再読み込み
  Future<void> _reload() async {
    setState(() {
      _futureUsers = QiitaClient.fetchUsers(_usersType, _userId);
    });
  }

  @override
  void initState() {
    super.initState();
    _usersType = widget.usersType;
    _userId = widget.userId;
    _futureUsers = QiitaClient.fetchUsers(_usersType, _userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(_usersType),
      body: SafeArea(
        child: FutureBuilder(
          future: _futureUsers,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Widget child = Container();

            if (snapshot.hasError) {
              child = ErrorView.networkErrorView(_reload);
            } else if (_currentPageNumber != 1) {
              child = usersListView();
            }

            if (snapshot.connectionState == ConnectionState.done) {
              _isLoading = false;
              if (snapshot.hasData) {
                _isNetworkError = false;
                if (_currentPageNumber == 1) {
                  _fetchedUsers = snapshot.data;
                  child = usersListView();
                } else if (snapshot.hasError) {
                  _isNetworkError = true;
                  child = ErrorView.networkErrorView(_reload);
                }
              }
            } else {
              if (_isNetworkError || _currentPageNumber == 1) {
                child = Center(child: CircularProgressIndicator());
              }
            }

            return Container(
              child: child,
            );
          },
        ),
      ),
    );
  }
}
