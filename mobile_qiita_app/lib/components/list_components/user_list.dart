import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/components/user_component_of_user_list.dart';
import 'package:mobile_qiita_app/models/user.dart';

// ユーザー一覧を表示
class UserList extends StatefulWidget {
  UserList({
    required this.onTapReload,
    required this.users,
    required this.scrollController,
    Key? key,
  }) : super(key: key);

  final Future<void> Function() onTapReload;
  final List<User> users;
  final ScrollController scrollController;

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {
    return widget.users.length < 20
        ? RefreshIndicator(
            onRefresh: widget.onTapReload,
            child: ListView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.users.length,
                  controller: widget.scrollController,
                  itemBuilder: (context, index) {
                    return UserComponentOfUserList(user: widget.users[index]);
                  },
                ),
              ],
            ),
          )
        : RefreshIndicator(
            onRefresh: widget.onTapReload,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.users.length,
              controller: widget.scrollController,
              itemBuilder: (context, index) {
                return UserComponentOfUserList(user: widget.users[index]);
              },
            ),
          );
  }
}
