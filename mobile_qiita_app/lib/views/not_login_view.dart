import 'package:flutter/material.dart';
import 'package:mobile_qiita_app/common/constants.dart';
import 'package:mobile_qiita_app/components/app_bar_component.dart';
import 'package:mobile_qiita_app/components/rounded_text_button.dart';

// MyPageで未ログインの場合に表示される画面
class NotLoginView extends StatelessWidget {
  const NotLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(title: 'MyPage', useBackButton: false),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('ログインが必要です'),
                    const SizedBox(height: 6.0),
                    const Text(
                      'マイページの機能を利用するには\nログインを行っていただく必要があります。',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              RoundedTextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                buttonText: 'ログインする',
                backgroundColor: Constants.lightSecondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
