import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/components/user_component_of_user_list.dart';
import 'package:mobile_qiita_app/models/user.dart';

class ListComponent {
  // ユーザー一覧を表示
  static Widget userListView(Future<void> Function() _onTapReload,
      List<User> _users, ScrollController _scrollController) {
    return _users.length < 20
        ? RefreshIndicator(
            onRefresh: _onTapReload,
            child: ListView(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _users.length,
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    return UserComponentOfUserList(user: _users[index]);
                  },
                ),
              ],
            ),
          )
        : RefreshIndicator(
            onRefresh: _onTapReload,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _users.length,
              controller: _scrollController,
              itemBuilder: (context, index) {
                return UserComponentOfUserList(user: _users[index]);
              },
            ),
          );
  }
}
