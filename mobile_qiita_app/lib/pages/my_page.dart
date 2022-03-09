import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/variables.dart';
import 'package:mobile_qiita_app/pages/user_page.dart';
import 'package:mobile_qiita_app/views/not_login_view.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  final bool _useBackButton = false;

  @override
  Widget build(BuildContext context) {
    final String _myPageAppBarTitle = 'MyPage';

    return Scaffold(
      body: Variables.isAuthenticated
          ? UserPage(
              user: Variables.authenticatedUser,
              appBarTitle: _myPageAppBarTitle,
              useBackButton: _useBackButton,
            )
          : NotLoginView(),
    );
  }
}
