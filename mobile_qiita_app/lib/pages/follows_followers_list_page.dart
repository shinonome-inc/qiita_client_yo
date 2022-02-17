// TODO: ページネーションの実装
// TODO: User Pageへ遷移

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/components/app_bar_component.dart';
import 'package:mobile_qiita_app/components/list_component.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBarComponent(title: _usersType, useBackButton: true),
      body: SafeArea(
        child: FutureBuilder(
          future: _futureUsers,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Widget child = Container();

            if (snapshot.hasError) {
              child = ErrorView.networkErrorView(_reload);
            } else if (_currentPageNumber != 1) {
              child = ListComponent.userListView(
                  _reload, _fetchedUsers, _scrollController);
            }

            if (snapshot.connectionState == ConnectionState.done) {
              _isLoading = false;
              if (snapshot.hasData) {
                _isNetworkError = false;
                if (_currentPageNumber == 1) {
                  _fetchedUsers = snapshot.data;
                  child = ListComponent.userListView(
                      _reload, _fetchedUsers, _scrollController);
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
