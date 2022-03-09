import 'package:flutter/material.dart';

// 未ログインの場合に表示
class NotLoginView extends StatelessWidget {
  const NotLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 40.0, bottom: 8.0),
                      child: const Text(
                        'ログインが必要です',
                      ),
                    ),
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
              FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                height: 48.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                ),
                child: const Text(
                  'ログインする',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
