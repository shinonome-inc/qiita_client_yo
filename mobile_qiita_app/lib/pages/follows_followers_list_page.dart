import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/components/app_bar_component.dart';
import 'package:mobile_qiita_app/components/list_components/user_list.dart';
import 'package:mobile_qiita_app/extension/pagination_scroll.dart';
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
  bool _isNetworkError = false;
  bool _isLoading = false;

  // 再読み込み
  Future<void> _reload() async {
    setState(() {
      _futureUsers = QiitaClient.fetchUsers(
          _currentPageNumber, widget.usersType, widget.userId);
    });
  }

  // ユーザーを追加読み込み
  Future<void> _readAdditionally() async {
    if (!_isLoading) {
      _isLoading = true;
      _currentPageNumber++;
      setState(() {
        _futureUsers = QiitaClient.fetchUsers(
            _currentPageNumber, widget.usersType, widget.userId);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _futureUsers = QiitaClient.fetchUsers(
        _currentPageNumber, widget.usersType, widget.userId);
    _scrollController.addListener(() {
      if (_scrollController.isBottom) {
        _readAdditionally();
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
      backgroundColor: Colors.white,
      appBar: AppBarComponent(title: widget.usersType, useBackButton: true),
      body: SafeArea(
        child: FutureBuilder(
          future: _futureUsers,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Widget child = Container();
            bool hasData = snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done;
            bool hasError = snapshot.hasError &&
                snapshot.connectionState == ConnectionState.done;
            bool isWaiting = (_isNetworkError || _currentPageNumber == 1) &&
                snapshot.connectionState == ConnectionState.waiting;

            if (_currentPageNumber != 1) {
              child = UserList(
                onTapReload: _reload,
                users: _fetchedUsers,
                scrollController: _scrollController,
              );
            }

            if (hasData && _currentPageNumber == 1) {
              _isLoading = false;
              _isNetworkError = false;
              _fetchedUsers = snapshot.data;
              child = UserList(
                onTapReload: _reload,
                users: _fetchedUsers,
                scrollController: _scrollController,
              );
            } else if (hasData) {
              _isLoading = false;
              _isNetworkError = false;
              _fetchedUsers.addAll(snapshot.data);
            } else if (hasError) {
              _isNetworkError = true;
              child = ErrorView.networkErrorView(_reload);
            } else if (isWaiting) {
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
    );
  }
}
