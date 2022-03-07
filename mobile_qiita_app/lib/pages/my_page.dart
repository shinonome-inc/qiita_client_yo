import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/variables.dart';
import 'package:mobile_qiita_app/pages/user_page.dart';
import 'package:mobile_qiita_app/views/error_views.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  final bool _useBackButton = false;

  @override
  Widget build(BuildContext context) {
    final String _myPageAppBarTitle = 'MyPage';

    return Scaffold(
      body: Variables.accessToken != null
          ? UserPage(
              user: Variables.authenticatedUser,
              appBarTitle: _myPageAppBarTitle,
              useBackButton: _useBackButton,
            )
          : ErrorView.notLoginView(context),
    );
  }
}
